// Get AWS account ID
data "aws_caller_identity" "current" {}
data "aws_region" "current" {}

####################
# EMR Service Role
####################

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

//The service role for EMR
resource "aws_iam_role" "emr_service_role" {
  name               = var.emr_service_role_name
  assume_role_policy = data.aws_iam_policy_document.emr_assume_role.json
}

//The minimal policy document for the EMR service role
data "aws_iam_policy_document" "emr_service_policy" {
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
      "ec2:DescribeAccountAttributes",
      "ec2:DescribeCapacityReservations",
      "ec2:DescribeDhcpOptions",
      "ec2:DescribeInstances",
      "ec2:DescribeLaunchTemplates",
      "ec2:DescribeNetworkAcls",
      "ec2:DescribeNetworkInterfaces",
      "ec2:DescribePlacementGroups",
      "ec2:DescribeRouteTables",
      "ec2:DescribeSecurityGroups",
      "ec2:DescribeSubnets",
      "ec2:DescribeVolumes",
      "ec2:DescribeVolumeStatus",
      "ec2:DescribeVpcAttribute",
      "ec2:DescribeVpcEndpoints",
      "ec2:DescribeVpcs",
      "ec2:DetachNetworkInterface",
      "ec2:ModifyImageAttribute",
      "ec2:ModifyInstanceAttribute",
      "ec2:RequestSpotInstances",
      "ec2:RevokeSecurityGroupEgress",
      "ec2:RunInstances",
      "ec2:TerminateInstances",
      "ec2:DeleteVolume",
      "ec2:DetachVolume",
      "ec2:DeleteLaunchTemplate",
      "ec2:CreateLaunchTemplate",
      "ec2:DescribeLaunchTemplates",
      "ec2:CreateFleet",
      "iam:GetRole",
      "iam:GetRolePolicy",
      "iam:ListInstanceProfiles",
      "iam:ListRolePolicies",
      "iam:PassRole",
      "cloudwatch:PutMetricAlarm",
      "cloudwatch:DescribeAlarms",
      "cloudwatch:DeleteAlarms",
    ]
    resources = ["*"]
    condition {
      test = "StringEquals"
      variable = "for-use-with-tamr-emr"
      values = ["true"]
    }
  }
  //The following permissions are for the cluster get/put S3 bucket info and objects for logs
  statement {
    effect = "Allow"
    actions = [
      "s3:GetAccelerateConfiguration",
      "s3:GetAccessPoint",
      "s3:GetAccessPointConfigurationForObjectLambda",
      "s3:GetAccessPointForObjectLambda",
      "s3:GetAccessPointPolicy",
      "s3:GetAccessPointPolicyForObjectLambda",
      "s3:GetAccessPointPolicyStatus",
      "s3:GetAccessPointPolicyStatusForObjectLambda",
      "s3:GetAccountPublicAccessBlock",
      "s3:GetAnalyticsConfiguration",
      "s3:GetBucketAcl",
      "s3:GetBucketCORS",
      "s3:GetBucketLocation",
      "s3:GetBucketLogging",
      "s3:GetBucketNotification",
      "s3:GetBucketObjectLockConfiguration",
      "s3:GetBucketOwnershipControls",
      "s3:GetBucketPolicy",
      "s3:GetBucketPolicyStatus",
      "s3:GetBucketPublicAccessBlock",
      "s3:GetBucketRequestPayment",
      "s3:GetBucketTagging",
      "s3:GetBucketVersioning",
      "s3:GetBucketWebsite",
      "s3:GetEncryptionConfiguration",
      "s3:GetIntelligentTieringConfiguration",
      "s3:GetInventoryConfiguration",
      "s3:GetJobTagging",
      "s3:GetLifecycleConfiguration",
      "s3:GetMetricsConfiguration",
      "s3:GetObject",
      "s3:GetObjectAcl",
      "s3:GetObjectLegalHold",
      "s3:GetObjectRetention",
      "s3:GetObjectTagging",
      "s3:GetObjectTorrent",
      "s3:GetObjectVersion",
      "s3:GetObjectVersionAcl",
      "s3:GetObjectVersionForReplication",
      "s3:GetObjectVersionTagging",
      "s3:GetObjectVersionTorrent",
      "s3:GetReplicationConfiguration",
      "s3:GetStorageLensConfiguration",
      "s3:GetStorageLensConfigurationTagging",
      "s3:GetStorageLensDashboard",
      "s3:ListAccessPoints",
      "s3:ListAccessPointsForObjectLambda",
      "s3:ListAllMyBuckets",
      "s3:ListBucket",
      "s3:ListBucketMultipartUploads",
      "s3:ListBucketVersions",
      "s3:ListJobs",
      "s3:ListMultipartUploadParts",
      "s3:ListStorageLensConfigurations",
      "s3:PutObject",
      "s3:PutObjectTagging"
    ]
    resources = [
      "arn:${var.arn_partition}:s3:::${var.s3_bucket_name_for_logs}",
      "arn:${var.arn_partition}:s3:::${var.s3_bucket_name_for_logs}/*"
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
resource "aws_iam_policy" "emr_service_policy" {
  name   = var.emr_service_iam_policy_name
  policy = data.aws_iam_policy_document.emr_service_policy.json
}

//The IAM role policy attachement that attaches the minimal policy to the role
resource "aws_iam_role_policy_attachment" "emr_service_role_policy" {
  role       = aws_iam_role.emr_service_role.name
  policy_arn = aws_iam_policy.emr_service_policy.arn
}

###########################
# EMR EC2 Instance Profile
###########################

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

//The IAM role for the EMR EC2 instance profile
resource "aws_iam_role" "emr_ec2_instance_profile" {
  name               = var.emr_ec2_role_name
  assume_role_policy = data.aws_iam_policy_document.ec2_assume_role.json
}

// The IAM role policy attachment(s) that attach s3 policy ARNs to the EMR EC2 iam role
resource "aws_iam_role_policy_attachment" "emr_ec2_s3_policies" {
  count      = length(var.s3_policy_arns)
  role       = aws_iam_role.emr_ec2_instance_profile.name
  policy_arn = element(var.s3_policy_arns, count.index)
}

//The IAM instance profile created from the above role for EMR EC2 instances
resource "aws_iam_instance_profile" "emr_ec2_instance_profile" {
  name = var.emr_ec2_instance_profile_name
  role = aws_iam_role.emr_ec2_instance_profile.name
}
