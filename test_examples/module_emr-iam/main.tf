module "emr-iam" {
  source = "../../modules/aws-emr-iam"

  s3_bucket_name_for_logs           = "bucket-name-logs"
  s3_bucket_name_for_root_directory = "bucket-name-root"
  s3_policy_arns                    = ["arn:aws:iam::aws:policy/AmazonS3FullAccess"]
  emr_ec2_iam_policy_name           = "hbase-terratest-ec2-policy"
  emr_service_iam_policy_name       = "hbase-terratest-service-policy"
  emr_service_role_name             = "hbase-terratest-service-role"
  emr_ec2_instance_profile_name     = "hbase-terratest-instance-profile"
  emr_ec2_role_name                 = "hbase-terratest-ec2-role"
}
