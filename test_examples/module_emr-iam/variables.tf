variable "s3_bucket_name_for_logs" {
  type = string
}
variable "s3_bucket_name_for_root_directory" {
  type = string
}
variable "additional_policy_arns" {
  type = list(string)
}
variable "emr_ec2_iam_policy_name" {
  type = string
}
variable "emr_service_iam_policy_name" {
  type = string
}
variable "emr_service_role_name" {
  type = string
}
variable "emr_ec2_instance_profile_name" {
  type = string
}
variable "emr_ec2_role_name" {
  type = string
}
