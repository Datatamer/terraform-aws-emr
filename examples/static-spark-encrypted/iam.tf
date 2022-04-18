//The minimal policy document to allow managing the KMS for the EMR service role
data "aws_iam_policy_document" "emr_service_policy_for_kms" {
  version = "2012-10-17"

  statement {
    sid    = "AllowKMS"
    effect = "Allow"
    actions = [
      "kms:Encrypt",
      "kms:Decrypt",
      "kms:ReEncrypt*",
      "kms:CreateGrant",
      "kms:GenerateDataKey",
      "kms:GenerateDataKeyWithoutPlaintext",
      "kms:DescribeKey"
    ]
    resources = [local.effective_kms_key_arn]
  }
}

//The policy that attaches the minimal policy document to allow the KMS use
resource "aws_iam_policy" "emr_service_policy_for_kms" {
  name   = format("%s-%s", var.name_prefix, "kms-encryption")
  policy = data.aws_iam_policy_document.emr_service_policy_for_kms.json
  tags   = var.tags
}

//The IAM role policy attachement that attaches the minimal policy to the role to allow the KMS use
resource "aws_iam_role_policy_attachment" "emr_service_role_policy_for_kms" {
  role       = module.emr-spark.emr_service_role_name
  policy_arn = aws_iam_policy.emr_service_policy_for_kms.arn
}
