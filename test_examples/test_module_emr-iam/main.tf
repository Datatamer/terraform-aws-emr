module "emr-iam" {
  source = "../../modules/aws-emr-iam"

  s3_bucket_name_for_logs           = "bucket-name-logs"                             // var.s3_bucket_name_for_logs
  s3_bucket_name_for_root_directory = "bucket-name-root"                             // var.s3_bucket_name_for_root_directory
  s3_policy_arns                    = ["arn:aws:iam::aws:policy/AmazonS3FullAccess"] // var.s3_policy_arns
  emr_ec2_iam_policy_name           = "hbase-terratest-ec2-policy"                   // var.emr_ec2_iam_policy_name
  emr_service_iam_policy_name       = "hbase-terratest-service-policy"               // var.emr_service_iam_policy_name
  emr_service_role_name             = "hbase-terratest-service-role"                 // var.emr_service_role_name
  emr_ec2_instance_profile_name     = "hbase-terratest-instance-profile"             // var.emr_ec2_instance_profile_name
  emr_ec2_role_name                 = "hbase-terratest-ec2-role"                     // var.emr_ec2_role_name
}
