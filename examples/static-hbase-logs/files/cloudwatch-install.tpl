#!/bin/bash
# Grab local variables
os=$(awk -F= '/^NAME/{print $2}' /etc/os-release)
arch="amd64"
# Grab instance ID using AWS Metadata Api Server v2
id=$(TOKEN=`curl -X PUT "http://169.254.169.254/latest/api/token" -H "X-aws-ec2-metadata-token-ttl-seconds: 21600"` \
&& curl -H "X-aws-ec2-metadata-token: $TOKEN" -v http://169.254.169.254/latest/meta-data/instance-id)

# Detect Architecture
if [ "$(arch)" = "aarch64" ]
then
arch="arm64"
fi

# Detect OS
if [ "$os" = "\"Ubuntu\"" ]
then
extension="deb"
installer="dpkg"
osv="ubuntu"
else
extension="rpm"
installer="rpm"
osv="amazon_linux"
fi

echo "********** Downloading Cloudwatch Agent for x86_x64 Architecture **********"
curl https://s3.${region}.amazonaws.com/amazoncloudwatch-agent-${region}/$osv/$arch/latest/amazon-cloudwatch-agent.$extension --output agent.$extension

if [[ $(ls -la | grep agent) ]];
then
echo "Cloudwatch agent installation file was found."
else
echo "Could not download the Cloudwatch agent installation file."
exit 1
fi

echo "********** Installing Cloudwatch Agent **********"
sudo $installer -i ./agent.$extension

cd /opt/aws/amazon-cloudwatch-agent/etc/
sudo touch cloudwatch-config.json
echo " {
    \"logs\": {
            \"endpoint_override\": \"${endpoint}\",
      \"logs_collected\": {
             \"files\": {
                 \"collect_list\": [
                     {
                         \"file_path\": \"/emr/instance-controller/log/bootstrap-actions/**.log\",
                         \"log_group_name\": \"${log_group}\",
                         \"log_stream_name\": \"$id-bootstrap-actions\",
                         \"timestamp_format\": \"%H: %M: %S%y%b%-d\"
                     },
                     {
                         \"file_path\": \"/emr/instance-controller/log/**.log\",
                         \"log_group_name\": \"${log_group}\",
                         \"log_stream_name\": \"$id-controller-log\",
                         \"timestamp_format\": \"%H: %M: %S%y%b%-d\"
                     },
                     {
                         \"file_path\": \"/emr/instance-state/**.log*\",
                         \"log_group_name\": \"${log_group}\",
                         \"log_stream_name\": \"$id-instance-state\",
                         \"timestamp_format\": \"%H: %M: %S%y%b%-d\"
                     },
                     {
                         \"file_path\": \"/emr/service-nanny\",
                         \"log_group_name\": \"${log_group}\",
                         \"log_stream_name\": \"$id-emr-service-nammy\",
                         \"timestamp_format\": \"%H: %M: %S%y%b%-d\"
                     },
                     {
                         \"file_path\": \"/mnt/var/log/hadoop-state-pusher\",
                         \"log_group_name\": \"${log_group}\",
                         \"log_stream_name\": \"$id-hadoop-state-pusher\",
                         \"timestamp_format\": \"%H: %M: %S%y%b%-d\"
                     },
                     {
                         \"file_path\": \"/mnt/var/log/hbase/**.log\",
                         \"log_group_name\": \"${log_group}\",
                         \"log_stream_name\": \"$id-hbase-logs\",
                         \"timestamp_format\": \"%H: %M: %S%y%b%-d\"
                     }
                 ]
              }
          }
      }
  } " | sudo tee cloudwatch-config.json

  echo "********** Mounting Cloudwatch Agent config file to Cloduwatch Agent **********"
  sudo /opt/aws/amazon-cloudwatch-agent/bin/amazon-cloudwatch-agent-ctl -a fetch-config -m ec2 -s -c file:/opt/aws/amazon-cloudwatch-agent/etc/cloudwatch-config.json


if [ "$os" = "\"Ubuntu\"" ]
then
echo "********** Starting Cloudwatch Agent **********"
sudo   systemctl start amazon-cloudwatch-agent.service
else
echo "********** Starting Cloudwatch Agent **********"
sudo   amazon-cloudwatch-agent-ctl -a start
fi
