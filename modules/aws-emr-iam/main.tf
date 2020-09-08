//The assume role policy document that will be used by the EMR service role
data "aws_iam_policy_document" "emr_assume_role" {
  statement {
    effect = "Allow"

    principals {
      type        = "Service"
      identifiers = ["elasticmapreduce.amazonaws.com"]
    }

    actions = ["sts:AssumeRole"]
  }
}

//The service role for EMR Hbase
resource "aws_iam_role" "emr_hbase_service_role" {
  name               = var.emr_service_role_name
  assume_role_policy = data.aws_iam_policy_document.emr_assume_role.json
}

//The minimal policy document for the EMR Hbase service role
data "aws_iam_policy_document" "emr_hbase_policy" {
  version = "2012-10-17"
  statement {
    effect = "Allow"
    actions = [
      "ec2:AuthorizeSecurityGroupEgress",
      "ec2:AuthorizeSecurityGroupIngress",
      "ec2:CancelSpotInstanceRequests",
      "ec2:CreateNetworkInterface",
      "ec2:CreateTags",
      "ec2:DeleteNetworkInterface",
      "ec2:DeleteTags",
      "ec2:Describe*",
      "ec2:DetachNetworkInterface",
      "ec2:ModifyImageAttribute",
      "ec2:ModifyInstanceAttribute",
      "ec2:RequestSpotInstances",
      "ec2:RevokeSecurityGroupEgress",
      "ec2:RunInstances",
      "ec2:TerminateInstances",
      "ec2:DeleteVolume",
      "ec2:DetachVolume",
      "iam:GetRole",
      "iam:GetRolePolicy",
      "iam:ListInstanceProfiles",
      "iam:ListRolePolicies",
      "iam:PassRole",
      "sqs:CreateQueue",
      "sqs:Delete*",
      "sqs:GetQueue*",
      "sqs:PurgeQueue",
      "sqs:ReceiveMessage",
      "cloudwatch:PutMetricAlarm",
      "cloudwatch:DescribeAlarms",
      "cloudwatch:DeleteAlarms",
    ]
    resources = ["*"]
  }
  //The following permissions are for hbase cluster get S3 bucket info and objects for EMR Hbase logs (read only permissions)
  statement {
    effect = "Allow"
    actions = [
      "s3:Get*",
      "s3:List*",
      "s3:PutObject",
      "s3:PutObjectTagging"
    ]
    resources = [
      "arn:aws:s3:::${var.s3_bucket_name_for_hbase_logs}",
      "arn:aws:s3:::${var.s3_bucket_name_for_hbase_logs}/*"
    ]
  }
  //The following permission passes the EC2 instance profile role to the EC2 instances created by the EMR cluster
  statement {
    effect = "Allow"
    actions = [
      "iam:PassRole"
    ]
    resources = [
      aws_iam_role.emr_ec2_instance_profile.arn
    ]
  }
}

//The policy that attaches the minimal policy document
resource "aws_iam_policy" "emr_hbase_policy" {
  name   = var.emr_service_iam_policy_name
  policy = data.aws_iam_policy_document.emr_hbase_policy.json
}

//The IAM role policy attachement that attaches the minimal policy to the role
resource "aws_iam_role_policy_attachment" "emr_hbase_service_role" {
  role       = aws_iam_role.emr_hbase_service_role.name
  policy_arn = aws_iam_policy.emr_hbase_policy.arn
}

//The assume role policy document for the IAM instance profile for EMR EC2 instances
data "aws_iam_policy_document" "ec2_assume_role" {
  statement {
    effect = "Allow"

    principals {
      type        = "Service"
      identifiers = ["ec2.amazonaws.com"]
    }

    actions = ["sts:AssumeRole"]
  }
}

//The IAM policy document that contains that minimal permissions for EMR EC2 instances
data "aws_iam_policy_document" "emr_hbase_ec2_policy" {
  version = "2012-10-17"
  statement {
    effect = "Allow"
    actions = [
      "ec2:Describe*",
      "elasticmapreduce:Describe*",
      "elasticmapreduce:ListBootstrapActions",
      "elasticmapreduce:ListClusters",
      "elasticmapreduce:ListInstanceGroups",
      "elasticmapreduce:ListInstances",
      "elasticmapreduce:ListSteps"
    ]
    resources = ["*"]
  }
  statement {
    effect = "Allow"
    actions = [
      "s3:GetBucketLocation",
      "s3:GetBucketCORS",
      "s3:GetObjectVersionForReplication",
      "s3:GetObject",
      "s3:GetBucketTagging",
      "s3:GetObjectVersion",
      "s3:GetObjectTagging",
      "s3:ListMultipartUploadParts",
      "s3:ListBucketByTags",
      "s3:ListBucket",
      "s3:ListObjects",
      "s3:ListObjectsV2",
      "s3:ListBucketMultipartUploads",
      "s3:PutObject",
      "s3:PutObjectTagging",
      "s3:HeadBucket",
      "s3:DeleteObject"
    ]
    resources = [
      "arn:aws:s3:::${var.s3_bucket_name_for_hbase_root_directory}",
      "arn:aws:s3:::${var.s3_bucket_name_for_hbase_root_directory}/*",
    ]
  }

  statement {
    effect = "Allow"
    actions = [
      "dynamodb:BatchGetItem",
      "dynamodb:BatchWriteItem",
      "dynamodb:PutItem",
      "dynamodb:DescribeTable",
      "dynamodb:DeleteItem",
      "dynamodb:GetItem",
      "dynamodb:Scan",
      "dynamodb:Query",
      "dynamodb:UpdateItem",
      "dynamodb:UpdateTable",
      "dynamodb:CreateTable",
    ]
    resources = [
      "arn:aws:dynamodb:${var.aws_region_of_dynamodb_table}:${var.aws_account_id}:table/${var.emrfs_metadata_table_name}"
    ]
  }

  statement {
    effect = "Allow"
    actions = [
      "cloudwatch:PutMetricData",
      "dynamodb:ListTables",
      "s3:HeadBucket",
    ]
    resources = [
      "*",
    ]
  }

  statement {
    effect = "Allow"
    actions = [
      "s3:PutObject",
    ]
    resources = [
      "arn:aws:s3:::${var.s3_bucket_name_for_hbase_logs}",
      "arn:aws:s3:::${var.s3_bucket_name_for_hbase_logs}/*"
    ]
  }
}

//The IAM role for the EMR EC2 instance profile
resource "aws_iam_role" "emr_ec2_instance_profile" {
  name               = var.emr_ec2_role_name
  assume_role_policy = data.aws_iam_policy_document.ec2_assume_role.json
}

//The IAM policy that connects the minimal IAM policy document
resource "aws_iam_policy" "emr_ec2_iam_policy" {
  name   = var.emr_ec2_iam_policy_name
  policy = data.aws_iam_policy_document.emr_hbase_ec2_policy.json
}

//The IAM role policy attachment that attaches the minimal policy to the IAM role
resource "aws_iam_role_policy_attachment" "emr_ec2_instance_profile" {
  role       = aws_iam_role.emr_ec2_instance_profile.name
  policy_arn = aws_iam_policy.emr_ec2_iam_policy.arn
}

//The IAM instance profile created from the above role for EMR EC2 instances
resource "aws_iam_instance_profile" "emr_ec2_instance_profile" {
  name = var.emr_ec2_instance_profile_name
  role = aws_iam_role.emr_ec2_instance_profile.name
}
