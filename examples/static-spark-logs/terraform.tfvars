bucket_name_for_root_directory = "poc-cw-root-directory-bucket"
bucket_name_for_logs           = "poc-cw-logs-bucket"
ingress_cidr_blocks            = [] # Replace me
name_prefix                    = "poc-cw-without-vpc"
key_pair                       = "fd-emr-test"
vpc_id                         = "vpc-01b63eaa58296f88c"                                             # <---- Replace me
application_subnet_id          = "subnet-05d261107e6434fb1"                                          # <---- Replace me
compute_subnet_id              = "subnet-09b99247bb12f7f39"                                          # <---- Replace me
vpce_logs_endpoint_dnsname     = "vpce-0ef8d5634d7795af8-p0888dsr.logs.us-east-2.vpce.amazonaws.com" # <---- Replace me
