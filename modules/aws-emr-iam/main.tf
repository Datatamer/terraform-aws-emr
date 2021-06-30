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
data "aws_iam_policy_document" "emr_service_policy_1" {
  version = "2012-10-17"

  statement {
    effect = "Allow"
    actions = [
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
    ]
    resources = ["*"]
  }

  statement {
    effect = "Allow"
    actions = [
      "iam:GetRole",
      "iam:GetRolePolicy",
      "iam:ListInstanceProfiles",
      "iam:ListRolePolicies",
      "iam:PassRole"
    ]
    resources = ["*"]
  }

  statement {
    effect = "Allow"
    actions =  [
      "ec2:CreateTags",
      "ec2:DeleteTags"
    ]
    resources = [
      "*"
      #"arn:${var.arn_partition}:ec2:${data.aws_region.current.name}:${data.aws_caller_identity.current.account_id}:instance/*",
      #"arn:${var.arn_partition}:ec2:${data.aws_region.current.name}:${data.aws_caller_identity.current.account_id}:volume/*",
      #"arn:${var.arn_partition}:ec2:${data.aws_region.current.name}:${data.aws_caller_identity.current.account_id}:network-interface/*",
      #"arn:${var.arn_partition}:ec2:${data.aws_region.current.name}:${data.aws_caller_identity.current.account_id}:launch-template/*",
      #"arn:${var.arn_partition}:ec2:${data.aws_region.current.name}:${data.aws_caller_identity.current.account_id}:security-group/*",
      #"arn:${var.arn_partition}:ec2:${data.aws_region.current.name}:${data.aws_caller_identity.current.account_id}:placement-group/*"
    ]
  }

  statement {
    effect = "Allow"
    actions = [
      "ec2:AuthorizeSecurityGroupEgress",
      "ec2:AuthorizeSecurityGroupIngress",
      "ec2:RevokeSecurityGroupEgress",
      "ec2:RevokeSecurityGroupIngress",
    ]
    resources = [
      "arn:${var.arn_partition}:ec2:${data.aws_region.current.name}:${data.aws_caller_identity.current.account_id}:security-group/*",
    ]
  }

  statement {
    effect = "Allow"
    actions = [
      "ec2:CancelSpotInstanceRequests",
    ]
    resources = [
      "arn:${var.arn_partition}:ec2:${data.aws_region.current.name}:${data.aws_caller_identity.current.account_id}:spot-instances-request/*"

    ]
  }
  statement {
    effect = "Allow"
    actions = [
      "ec2:RequestSpotInstances",
    ]
    resources = [
      "arn:${var.arn_partition}:ec2:${data.aws_region.current.name}:${data.aws_caller_identity.current.account_id}:spot-instances-request/*",
      "arn:${var.arn_partition}:ec2:${data.aws_region.current.name}:${data.aws_caller_identity.current.account_id}:security-group/*",
      "arn:${var.arn_partition}:ec2:${data.aws_region.current.name}:${data.aws_caller_identity.current.account_id}:subnet/*",
      "arn:${var.arn_partition}:ec2:${data.aws_region.current.name}:${data.aws_caller_identity.current.account_id}:key-pair/*",
      "arn:${var.arn_partition}:ec2:${data.aws_region.current.name}::image/*",
    ]
  }
  statement {
    effect = "Allow"
    actions = [
      "ec2:CreateNetworkInterface"
    ]
    resources = [
      "arn:${var.arn_partition}:ec2:${data.aws_region.current.name}:${data.aws_caller_identity.current.account_id}:network-interface/*",
      "arn:${var.arn_partition}:ec2:${data.aws_region.current.name}:${data.aws_caller_identity.current.account_id}:subnet/*",
      "arn:${var.arn_partition}:ec2:${data.aws_region.current.name}:${data.aws_caller_identity.current.account_id}:security-group/*",
    ]
  }

  statement {
    effect = "Allow"
    actions = [
      "ec2:DeleteNetworkInterface"
    ]
    resources = [
      "arn:${var.arn_partition}:ec2:${data.aws_region.current.name}:${data.aws_caller_identity.current.account_id}:network-interface/*",
    ]
  }
  statement {
    effect = "Allow"
    actions = [
      "ec2:DetachNetworkInterface",
    ]
    resources = [
      "arn:${var.arn_partition}:ec2:${data.aws_region.current.name}:${data.aws_caller_identity.current.account_id}:instance/*",
      "arn:${var.arn_partition}:ec2:${data.aws_region.current.name}:${data.aws_caller_identity.current.account_id}:network-interface/*",
    ]
  }

  statement {
    effect = "Allow"
    actions = [
      "ec2:ModifyImageAttribute"
    ]
    resources = [
      "arn:${var.arn_partition}:ec2:${data.aws_region.current.name}::image/*",
    ]
  }
  statement {
    effect = "Allow"
    actions = [
      "ec2:ModifyInstanceAttribute"
    ]
    resources = [
      "arn:${var.arn_partition}:ec2:${data.aws_region.current.name}:${data.aws_caller_identity.current.account_id}:instance/*",
      "arn:${var.arn_partition}:ec2:${data.aws_region.current.name}:${data.aws_caller_identity.current.account_id}:volume/*",
      "arn:${var.arn_partition}:ec2:${data.aws_region.current.name}:${data.aws_caller_identity.current.account_id}:security-group/*",
    ]
  }

  statement {
    effect = "Allow"
    actions = [
      "ec2:RunInstances"
    ]
    resources = [
      "*"
      #"arn:${var.arn_partition}:ec2:${data.aws_region.current.name}::image/*",
      #"arn:${var.arn_partition}:ec2:${data.aws_region.current.name}:${data.aws_caller_identity.current.account_id}:instance/*",
      #"arn:${var.arn_partition}:ec2:${data.aws_region.current.name}:${data.aws_caller_identity.current.account_id}:network-interface/*",
      #"arn:${var.arn_partition}:ec2:${data.aws_region.current.name}:${data.aws_caller_identity.current.account_id}:security-group/*",
      #"arn:${var.arn_partition}:ec2:${data.aws_region.current.name}:${data.aws_caller_identity.current.account_id}:subnet/*",
      #"arn:${var.arn_partition}:ec2:${data.aws_region.current.name}:${data.aws_caller_identity.current.account_id}:volume/*",
      #"arn:${var.arn_partition}:ec2:${data.aws_region.current.name}::image/*",
      #"arn:${var.arn_partition}:ec2:${data.aws_region.current.name}:${data.aws_caller_identity.current.account_id}:capacity-reservation/*",
      #"arn:${var.arn_partition}:ec2:${data.aws_region.current.name}:${data.aws_caller_identity.current.account_id}:elastic-gpu/*",
      #"arn:${var.arn_partition}:elastic-inference:${data.aws_region.current.name}:${data.aws_caller_identity.current.account_id}:elastic-inference-accelerator/*",
      #"arn:${var.arn_partition}:ec2:${data.aws_region.current.name}:${data.aws_caller_identity.current.account_id}:key-pair/*",
      #"arn:${var.arn_partition}:ec2:${data.aws_region.current.name}:${data.aws_caller_identity.current.account_id}:launch-template/*",
      #"arn:${var.arn_partition}:ec2:${data.aws_region.current.name}:${data.aws_caller_identity.current.account_id}:placement-group/*",
      #"arn:${var.arn_partition}:ec2:${data.aws_region.current.name}::snapshot/*",
    ]
  }
  statement {
    effect = "Allow"
    actions = [
      "ec2:TerminateInstances"
    ]
    resources = [
      "arn:${var.arn_partition}:ec2:${data.aws_region.current.name}:${data.aws_caller_identity.current.account_id}:instance/*",
    ]
  }
}

//The minimal policy document for the EMR service role
data "aws_iam_policy_document" "emr_service_policy_2" {
  version = "2012-10-17"

  statement {
    effect = "Allow"
    actions = [
      "ec2:DeleteVolume"
    ]
    resources = [
      "arn:${var.arn_partition}:ec2:${data.aws_region.current.name}:${data.aws_caller_identity.current.account_id}:volume/*"
    ]
  }
  statement {
    effect = "Allow"
    actions = [
      "ec2:DetachVolume"
    ]
    resources = [
      "arn:${var.arn_partition}:ec2:${data.aws_region.current.name}:${data.aws_caller_identity.current.account_id}:volume/*",
      "arn:${var.arn_partition}:ec2:${data.aws_region.current.name}:${data.aws_caller_identity.current.account_id}:instance/*",
    ]
  }

  statement {
    effect = "Allow"
    actions = [
      "ec2:CreateFleet"
    ]
    resources = [
      "arn:${var.arn_partition}:ec2:${data.aws_region.current.name}:${data.aws_caller_identity.current.account_id}:fleet/*",
      "arn:${var.arn_partition}:ec2:${data.aws_region.current.name}::image/*",
      "arn:${var.arn_partition}:ec2:${data.aws_region.current.name}:${data.aws_caller_identity.current.account_id}:key-pair/*",
      "arn:${var.arn_partition}:ec2:${data.aws_region.current.name}:${data.aws_caller_identity.current.account_id}:launch-template/*",
      "arn:${var.arn_partition}:ec2:${data.aws_region.current.name}:${data.aws_caller_identity.current.account_id}:network-interface/*",
      "arn:${var.arn_partition}:ec2:${data.aws_region.current.name}:${data.aws_caller_identity.current.account_id}:security-group/*",
      "arn:${var.arn_partition}:ec2:${data.aws_region.current.name}::snapshot/*",
      "arn:${var.arn_partition}:ec2:${data.aws_region.current.name}:${data.aws_caller_identity.current.account_id}:subnet/*",
      "arn:${var.arn_partition}:ec2:${data.aws_region.current.name}:${data.aws_caller_identity.current.account_id}:volume/*",
      "arn:${var.arn_partition}:ec2:${data.aws_region.current.name}:${data.aws_caller_identity.current.account_id}:instance/*",
      "arn:${var.arn_partition}:ec2:${data.aws_region.current.name}:${data.aws_caller_identity.current.account_id}:capacity-reservation/*",
      "arn:${var.arn_partition}:ec2:${data.aws_region.current.name}:${data.aws_caller_identity.current.account_id}:placement-group/*",
      "arn:${var.arn_partition}:ec2:${data.aws_region.current.name}:${data.aws_caller_identity.current.account_id}:dedicated-host/*",
      "arn:${var.arn_partition}:resource-groups:${data.aws_region.current.name}:${data.aws_caller_identity.current.account_id}:group-host/*",
    ]
  }
  statement {
    effect = "Allow"
    actions = [
      "ec2:CreateLaunchTemplate"
    ]
    resources = [
      "*"
      #"arn:${var.arn_partition}:ec2:${data.aws_region.current.name}:${data.aws_caller_identity.current.account_id}:launch-template/*",
      #"arn:${var.arn_partition}:ec2:${data.aws_region.current.name}:${data.aws_caller_identity.current.account_id}:capacity-reservation/*",
      #"arn:${var.arn_partition}:ec2:${data.aws_region.current.name}:${data.aws_caller_identity.current.account_id}:dedicated-host/*",
      #"arn:${var.arn_partition}:ec2:${data.aws_region.current.name}::image/*",
      #"arn:${var.arn_partition}:ec2:${data.aws_region.current.name}:${data.aws_caller_identity.current.account_id}:key-pair/*",
      #"arn:${var.arn_partition}:ec2:${data.aws_region.current.name}:${data.aws_caller_identity.current.account_id}:network-interface/*",
      #"arn:${var.arn_partition}:ec2:${data.aws_region.current.name}:${data.aws_caller_identity.current.account_id}:placement-group/*",
      #"arn:${var.arn_partition}:ec2:${data.aws_region.current.name}:${data.aws_caller_identity.current.account_id}:security-group/*",
      #"arn:${var.arn_partition}:ec2:${data.aws_region.current.name}::snapshot/*",
      #"arn:${var.arn_partition}:ec2:${data.aws_region.current.name}:${data.aws_caller_identity.current.account_id}:subnet/*",
    ]
  }
  statement {
    effect = "Allow"
    actions = [
      "ec2:DeleteLaunchTemplate"
    ]
    resources = [
      "arn:${var.arn_partition}:ec2:${data.aws_region.current.name}:${data.aws_caller_identity.current.account_id}:launch-template/*"
    ]
  }

  statement {
    effect = "Allow"
    actions = [
      "cloudwatch:PutMetricAlarm",
      "cloudwatch:DescribeAlarms",
      "cloudwatch:DeleteAlarms"
    ]
    resources = [
      "arn:${var.arn_partition}:cloudwatch:${data.aws_region.current.name}:${data.aws_caller_identity.current.account_id}:alarm:*"
    ]
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
resource "aws_iam_policy" "emr_service_policy_1" {
  name   = "${var.emr_service_iam_policy_name}-1"
  policy = data.aws_iam_policy_document.emr_service_policy_1.json
}

//The policy that attaches the minimal policy document
resource "aws_iam_policy" "emr_service_policy_2" {
  name   = "${var.emr_service_iam_policy_name}-2"
  policy = data.aws_iam_policy_document.emr_service_policy_2.json
}

//The IAM role policy attachement that attaches the minimal policy to the role
resource "aws_iam_role_policy_attachment" "emr_service_role_policy_1" {
  role       = aws_iam_role.emr_service_role.name
  policy_arn = aws_iam_policy.emr_service_policy_1.arn
}

resource "aws_iam_role_policy_attachment" "emr_service_role_policy_2" {
  role       = aws_iam_role.emr_service_role.name
  policy_arn = aws_iam_policy.emr_service_policy_2.arn
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

