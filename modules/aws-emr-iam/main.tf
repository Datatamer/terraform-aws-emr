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
  name                 = var.emr_service_role_name
  assume_role_policy   = data.aws_iam_policy_document.emr_assume_role.json
  permissions_boundary = var.permissions_boundary
  tags                 = var.tags
}

//The minimal policy document for the EMR service role
data "aws_iam_policy_document" "emr_service_policy_1" {
  version = "2012-10-17"

  # Describe Actions have neither Resource or Conditions specifications
  # See more in https://docs.aws.amazon.com/service-authorization/latest/reference/list_amazonec2.html
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

  ## ABAC OK - copied from docs
  statement {
    sid    = "ManageTagsOnEMRTaggedResources"
    effect = "Allow"
    actions = [
      "ec2:CreateTags",
      "ec2:DeleteTags"
    ]
    resources = [
      "arn:aws:ec2:*:*:instance/*",
      "arn:aws:ec2:*:*:volume/*",
      "arn:aws:ec2:*:*:network-interface/*",
      "arn:aws:ec2:*:*:launch-template/*"
    ]
    dynamic "condition" {
      for_each = var.abac_tags
      content {
        test     = "StringEquals"
        variable = "aws:ResourceTag/${condition.key}"
        values   = [condition.value]
      }
    }
  }
  ## ABAC OK - copied from docs
  statement {
    sid    = "TagOnCreateTaggedEMRResources"
    effect = "Allow"
    actions = [
      "ec2:CreateTags"
    ]
    resources = [
      "arn:aws:ec2:*:*:instance/*",
      "arn:aws:ec2:*:*:volume/*",
      "arn:aws:ec2:*:*:network-interface/*",
      "arn:aws:ec2:*:*:launch-template/*"
    ]
    condition {
      test     = "StringEquals"
      variable = "ec2:CreateAction"
      values = [
        "RunInstances",
        "CreateFleet",
        "CreateLaunchTemplate",
        "CreateNetworkInterface"
      ]
    }
  }

  ## ABAC OK - maybe we can add the specific SG - or maybe aint needed
  statement {
    sid    = "ManageSecurityGroups"
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
    dynamic "condition" {
      for_each = var.abac_tags
      content {
        test     = "StringEquals"
        variable = "aws:ResourceTag/${condition.key}"
        values   = [condition.value]
      }
    }
  }

  # This is not in the default abac policy. Gotta find out if it's needed to add any tag condition
  statement {
    effect = "Allow"
    actions = [
      "ec2:CancelSpotInstanceRequests",
    ]
    resources = [
      "arn:${var.arn_partition}:ec2:${data.aws_region.current.name}:${data.aws_caller_identity.current.account_id}:spot-instances-request/*"

    ]
  }
  # This is not in the default abac policy. Gotta find out if it's needed to add any tag condition
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

  ## OK ABAC (statement copied from docs)
  statement {
    sid    = "CreateInTaggedNetwork"
    effect = "Allow"
    actions = [
      "ec2:CreateNetworkInterface",
      "ec2:RunInstances",
      "ec2:CreateFleet",
      "ec2:CreateLaunchTemplate",
      "ec2:CreateLaunchTemplateVersion",
    ]
    resources = [
      "arn:${var.arn_partition}:ec2:${data.aws_region.current.name}:${data.aws_caller_identity.current.account_id}:subnet/*",
      "arn:${var.arn_partition}:ec2:${data.aws_region.current.name}:${data.aws_caller_identity.current.account_id}:security-group/*",
    ]
    dynamic "condition" {
      for_each = var.abac_tags
      content {
        test     = "StringEquals"
        variable = "aws:ResourceTag/${condition.key}"
        values   = [condition.value]
      }
    }
  }

  ## OK ABAC  (statement copied from docs)
  statement {
    sid    = "CreateNetworkInterfaceNeededForPrivateSubnet"
    effect = "Allow"
    actions = [
      "ec2:CreateNetworkInterface"
    ]
    resources = [
      "arn:${var.arn_partition}:ec2:${data.aws_region.current.name}:${data.aws_caller_identity.current.account_id}:network-interface/*"
    ]
    dynamic "condition" {
      for_each = var.abac_tags
      content {
        test     = "StringEquals"
        variable = "aws:RequestTag/${condition.key}"
        values   = [condition.value]
      }
    }
  }
  # ABAC OK - not sure this works, has to be tested. there was no example using this.
  statement {
    effect = "Allow"
    actions = [
      "ec2:DetachNetworkInterface",
    ]
    resources = [
      "arn:${var.arn_partition}:ec2:${data.aws_region.current.name}:${data.aws_caller_identity.current.account_id}:instance/*",
      "arn:${var.arn_partition}:ec2:${data.aws_region.current.name}:${data.aws_caller_identity.current.account_id}:network-interface/*",
    ]
    dynamic "condition" {
      for_each = var.abac_tags
      content {
        test     = "StringEquals"
        variable = "aws:ResourceTag/${condition.key}"
        values   = [condition.value]
      }
    }
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

  ## ABAC OK - Copied from Docs
  statement {
    sid    = "ManageEMRTaggedResources"
    effect = "Allow"
    actions = [
      "ec2:CreateLaunchTemplateVersion",
      "ec2:DeleteLaunchTemplate",
      "ec2:DeleteNetworkInterface",
      "ec2:ModifyInstanceAttribute",
      "ec2:TerminateInstances"
    ]
    resources = [
      "arn:${var.arn_partition}:ec2:${data.aws_region.current.name}:${data.aws_caller_identity.current.account_id}:*",
    ]
    dynamic "condition" {
      for_each = var.abac_tags
      content {
        test     = "StringEquals"
        variable = "aws:ResourceTag/${condition.key}"
        values   = [condition.value]
      }
    }
  }
}

//The minimal policy document for the EMR service role
data "aws_iam_policy_document" "emr_service_policy_2" {
  version = "2012-10-17"

  ## ABAC OK - not sure if it works
  statement {
    effect = "Allow"
    actions = [
      "ec2:DeleteVolume"
    ]
    resources = [
      "arn:${var.arn_partition}:ec2:${data.aws_region.current.name}:${data.aws_caller_identity.current.account_id}:volume/*"
    ]
    dynamic "condition" {
      for_each = var.abac_tags
      content {
        test     = "StringEquals"
        variable = "aws:ResourceTag/${condition.key}"
        values   = [condition.value]
      }
    }
  }
  ## ABAC - not sure if it works. has yet to be tested
  statement {
    effect = "Allow"
    actions = [
      "ec2:DetachVolume"
    ]
    resources = [
      "arn:${var.arn_partition}:ec2:${data.aws_region.current.name}:${data.aws_caller_identity.current.account_id}:volume/*",
      "arn:${var.arn_partition}:ec2:${data.aws_region.current.name}:${data.aws_caller_identity.current.account_id}:instance/*",
    ]
    dynamic "condition" {
      for_each = var.abac_tags
      content {
        test     = "StringEquals"
        variable = "aws:ResourceTag/${condition.key}"
        values   = [condition.value]
      }
    }
  }

  ## ABAC OK - Copied from Docs
  statement {
    sid    = "CreateWithEMRTaggedLaunchTemplate"
    effect = "Allow"
    actions = [
      "ec2:CreateFleet",
      "ec2:RunInstances",
      "ec2:CreateLaunchTemplateVersion"
    ]
    resources = [
      "arn:${var.arn_partition}:ec2:${data.aws_region.current.name}:${data.aws_caller_identity.current.account_id}:launch-template/*"
    ]
    dynamic "condition" {
      for_each = var.abac_tags
      content {
        test     = "StringEquals"
        variable = "aws:ResourceTag/${condition.key}"
        values   = [condition.value]
      }
    }
  }

  # ABAC OK - copied from docs
  statement {
    sid    = "CreateEMRTaggedLaunchTemplate"
    effect = "Allow"
    actions = [
      "ec2:CreateLaunchTemplate"
    ]
    resources = [
      "arn:${var.arn_partition}:ec2:${data.aws_region.current.name}:${data.aws_caller_identity.current.account_id}:launch-template/*"
    ]
    dynamic "condition" {
      for_each = var.abac_tags
      content {
        test     = "StringEquals"
        variable = "aws:RequestTag/${condition.key}"
        values   = [condition.value]
      }
    }
  }
  # ABAC OK - copied from docs
  statement {
    sid    = "CreateEMRTaggedInstancesAndVolumes"
    effect = "Allow"
    actions = [
      "ec2:RunInstances",
      "ec2:CreateFleet"
    ]
    resources = [
      "arn:${var.arn_partition}:ec2:${data.aws_region.current.name}:${data.aws_caller_identity.current.account_id}:volume/*",
      "arn:${var.arn_partition}:ec2:${data.aws_region.current.name}:${data.aws_caller_identity.current.account_id}:instance/*"
    ]
    dynamic "condition" {
      for_each = var.abac_tags
      content {
        test     = "StringEquals"
        variable = "aws:RequestTag/${condition.key}"
        values   = [condition.value]
      }
    }
  }
  # ABAC OK - copied from docs
  statement {
    sid    = "NotTaggableResourcesToLaunchEC2" # we may be able to specify specfic names (for ex key_pair_name is variable in this root module)
    effect = "Allow"
    actions = [
      "ec2:RunInstances",
      "ec2:CreateFleet",
      "ec2:CreateLaunchTemplate",
      "ec2:CreateLaunchTemplateVersion"
    ]
    resources = [
      "arn:${var.arn_partition}:ec2:${data.aws_region.current.name}:${data.aws_caller_identity.current.account_id}:key-pair/*",          # key pairs are not taggable
      "arn:${var.arn_partition}:ec2:${data.aws_region.current.name}::image/*",                                                           # images are not taggable?
      "arn:${var.arn_partition}:ec2:${data.aws_region.current.name}:${data.aws_caller_identity.current.account_id}:network-interface/*", # really not taggable? i want to check
      "arn:${var.arn_partition}:ec2:${data.aws_region.current.name}:${data.aws_caller_identity.current.account_id}:fleet/*"
    ]
  }

  ## in here just added the resource name suffix (has not been tested)
  statement {
    effect = "Allow"
    actions = [
      "cloudwatch:PutMetricAlarm",
      "cloudwatch:DescribeAlarms",
      "cloudwatch:DeleteAlarms"
    ]
    resources = [
      "arn:${var.arn_partition}:cloudwatch:${data.aws_region.current.name}:${data.aws_caller_identity.current.account_id}:alarm:*_EMR_Auto_Scaling"
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
  // ABAC OK
  //The following permission passes the EC2 instance profile role to the EC2 instances created by the EMR cluster
  statement {
    effect = "Allow"
    actions = [
      "iam:PassRole"
    ]
    resources = [
      aws_iam_role.emr_ec2_instance_profile.arn
    ]
    condition {
      test     = "StringLike"
      variable = "iam:PassedToService"
      values = [
        "ec2.amazonaws.com*"
      ]
    }
  }
}

//The policy that attaches the minimal policy document
resource "aws_iam_policy" "emr_service_policy_1" {
  name   = "${var.emr_service_iam_policy_name}-1"
  policy = data.aws_iam_policy_document.emr_service_policy_1.json
  tags   = var.tags
}

//The policy that attaches the minimal policy document
resource "aws_iam_policy" "emr_service_policy_2" {
  name   = "${var.emr_service_iam_policy_name}-2"
  policy = data.aws_iam_policy_document.emr_service_policy_2.json
  tags   = var.tags
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
  name                 = var.emr_ec2_role_name
  assume_role_policy   = data.aws_iam_policy_document.ec2_assume_role.json
  permissions_boundary = var.permissions_boundary
  tags                 = var.tags
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
  tags = var.tags
}
