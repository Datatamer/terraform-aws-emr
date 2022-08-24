locals {
  effective_kms_key_arn = var.kms_key_arn == "" ? aws_kms_key.kms_encryption_key[0].arn : var.kms_key_arn
  account_id            = data.aws_caller_identity.current.account_id
}

data "aws_caller_identity" "current" {}

//The minimal policy document for the KMS key
data "aws_iam_policy_document" "kms_key" {
  count   = var.kms_key_arn == "" ? 1 : 0
  version = "2012-10-17"

  statement {
    sid       = "Enable IAM User Permissions"
    effect    = "Allow"
    actions   = ["kms:*"]
    resources = ["*"]

    principals {
      type        = "AWS"
      identifiers = ["arn:aws:iam::${local.account_id}:root"]
    }
  }

  statement {
    sid    = "Allow use of the key"
    effect = "Allow"
    principals {
      type = "AWS"
      identifiers = [
        module.emr-spark.emr_ec2_role_arn,
        module.emr-spark.emr_service_role_arn
      ]
    }
    actions = [
      "kms:Encrypt",
      "kms:Decrypt",
      "kms:ReEncrypt*",
      "kms:GenerateDataKey*",
      "kms:DescribeKey"
    ]
    resources = ["*"]

  }

  statement {
    sid    = "Allow attachment of persistent resources"
    effect = "Allow"
    principals {
      type = "AWS"
      identifiers = [
        module.emr-spark.emr_ec2_role_arn,
        module.emr-spark.emr_service_role_arn
      ]
    }
    actions = [
      "kms:CreateGrant",
      "kms:ListGrants",
      "kms:RevokeGrant"
    ]
    resources = ["*"]
    condition {
      test     = "Bool"
      variable = "kms:GrantIsForAWSResource"
      values   = ["true"]
    }
  }
}

//Creates the KMS key and attaches the minimal policy
resource "aws_kms_key" "kms_encryption_key" {
  count                   = var.kms_key_arn == "" ? 1 : 0
  description             = "KMS for EBS encryption"
  policy                  = data.aws_iam_policy_document.kms_key[0].json
  deletion_window_in_days = 7
}

//Adds alias to the KMS key
resource "aws_kms_alias" "kms_encryption_key_alias" {
  count         = var.kms_key_arn == "" ? 1 : 0
  name          = format("%s-%s", "alias/${var.name_prefix}", "kms-encryption-key")
  target_key_id = aws_kms_key.kms_encryption_key[0].id
}
