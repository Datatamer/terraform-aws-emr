module "emr-iam" {
  source = "../../modules/aws-emr-iam"

  s3_bucket_name_for_logs           = var.s3_bucket_name_for_logs
  s3_bucket_name_for_root_directory = var.s3_bucket_name_for_root_directory
  additional_policy_arns            = var.additional_policy_arns
  emr_ec2_iam_policy_name           = var.emr_ec2_iam_policy_name
  emr_service_iam_policy_name       = var.emr_service_iam_policy_name
  emr_service_role_name             = var.emr_service_role_name
  emr_ec2_instance_profile_name     = var.emr_ec2_instance_profile_name
  emr_ec2_role_name                 = var.emr_ec2_role_name
  vpc_id                            = "vpc-1234567890123456"
}
