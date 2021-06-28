// Get AWS account ID
data "aws_caller_identity" "current" {}

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
      "ec2:DescribeAddresses",
      "ec2:DescribeAddressesAttribute",
      "ec2:DescribeAggregateIdFormat",
      "ec2:DescribeAvailabilityZones",
      "ec2:DescribeBundleTasks",
      "ec2:DescribeByoipCidrs",
      "ec2:DescribeCapacityReservations",
      "ec2:DescribeCarrierGateways",
      "ec2:DescribeClassicLinkInstances",
      "ec2:DescribeClientVpnAuthorizationRules",
      "ec2:DescribeClientVpnConnections",
      "ec2:DescribeClientVpnEndpoints",
      "ec2:DescribeClientVpnRoutes",
      "ec2:DescribeClientVpnTargetNetworks",
      "ec2:DescribeCoipPools",
      "ec2:DescribeConversionTasks",
      "ec2:DescribeCustomerGateways",
      "ec2:DescribeDhcpOptions",
      "ec2:DescribeEgressOnlyInternetGateways",
      "ec2:DescribeElasticGpus",
      "ec2:DescribeExportImageTasks",
      "ec2:DescribeExportTasks",
      "ec2:DescribeFastSnapshotRestores",
      "ec2:DescribeFleetHistory",
      "ec2:DescribeFleetInstances",
      "ec2:DescribeFleets",
      "ec2:DescribeFlowLogs",
      "ec2:DescribeFpgaImageAttribute",
      "ec2:DescribeFpgaImages",
      "ec2:DescribeHostReservationOfferings",
      "ec2:DescribeHostReservations",
      "ec2:DescribeHosts",
      "ec2:DescribeIamInstanceProfileAssociations",
      "ec2:DescribeIdentityIdFormat",
      "ec2:DescribeIdFormat",
      "ec2:DescribeImageAttribute",
      "ec2:DescribeImages",
      "ec2:DescribeImportImageTasks",
      "ec2:DescribeImportSnapshotTasks",
      "ec2:DescribeInstanceAttribute",
      "ec2:DescribeInstanceCreditSpecifications",
      "ec2:DescribeInstanceEventNotificationAttributes",
      "ec2:DescribeInstances",
      "ec2:DescribeInstanceStatus",
      "ec2:DescribeInstanceTypeOfferings",
      "ec2:DescribeInstanceTypes",
      "ec2:DescribeInternetGateways",
      "ec2:DescribeIpv6Pools",
      "ec2:DescribeKeyPairs",
      "ec2:DescribeLaunchTemplates",
      "ec2:DescribeLaunchTemplateVersions",
      "ec2:DescribeLocalGatewayRouteTables",
      "ec2:DescribeLocalGatewayRouteTableVirtualInterfaceGroupAssociations",
      "ec2:DescribeLocalGatewayRouteTableVpcAssociations",
      "ec2:DescribeLocalGateways",
      "ec2:DescribeLocalGatewayVirtualInterfaceGroups",
      "ec2:DescribeLocalGatewayVirtualInterfaces",
      "ec2:DescribeManagedPrefixLists",
      "ec2:DescribeMovingAddresses",
      "ec2:DescribeNatGateways",
      "ec2:DescribeNetworkAcls",
      "ec2:DescribeNetworkInsightsAnalyses",
      "ec2:DescribeNetworkInsightsPaths",
      "ec2:DescribeNetworkInterfaceAttribute",
      "ec2:DescribeNetworkInterfacePermissions",
      "ec2:DescribeNetworkInterfaces",
      "ec2:DescribePlacementGroups",
      "ec2:DescribePrefixLists",
      "ec2:DescribePrincipalIdFormat",
      "ec2:DescribePublicIpv4Pools",
      "ec2:DescribeRegions",
      "ec2:DescribeReplaceRootVolumeTasks",
      "ec2:DescribeReservedInstances",
      "ec2:DescribeReservedInstancesListings",
      "ec2:DescribeReservedInstancesModifications",
      "ec2:DescribeReservedInstancesOfferings",
      "ec2:DescribeRouteTables",
      "ec2:DescribeScheduledInstanceAvailability",
      "ec2:DescribeScheduledInstances",
      "ec2:DescribeSecurityGroupReferences",
      "ec2:DescribeSecurityGroups",
      "ec2:DescribeSnapshotAttribute",
      "ec2:DescribeSnapshots",
      "ec2:DescribeSpotDatafeedSubscription",
      "ec2:DescribeSpotFleetInstances",
      "ec2:DescribeSpotFleetRequestHistory",
      "ec2:DescribeSpotFleetRequests",
      "ec2:DescribeSpotInstanceRequests",
      "ec2:DescribeSpotPriceHistory",
      "ec2:DescribeStaleSecurityGroups",
      "ec2:DescribeStoreImageTasks",
      "ec2:DescribeSubnets",
      "ec2:DescribeTags",
      "ec2:DescribeTrafficMirrorFilters",
      "ec2:DescribeTrafficMirrorSessions",
      "ec2:DescribeTrafficMirrorTargets",
      "ec2:DescribeTransitGatewayAttachments",
      "ec2:DescribeTransitGatewayConnectPeers",
      "ec2:DescribeTransitGatewayConnects",
      "ec2:DescribeTransitGatewayMulticastDomains",
      "ec2:DescribeTransitGatewayPeeringAttachments",
      "ec2:DescribeTransitGatewayRouteTables",
      "ec2:DescribeTransitGateways",
      "ec2:DescribeTransitGatewayVpcAttachments",
      "ec2:DescribeVolumeAttribute",
      "ec2:DescribeVolumes",
      "ec2:DescribeVolumesModifications",
      "ec2:DescribeVolumeStatus",
      "ec2:DescribeVpcAttribute",
      "ec2:DescribeVpcClassicLink",
      "ec2:DescribeVpcClassicLinkDnsSupport",
      "ec2:DescribeVpcEndpointConnectionNotifications",
      "ec2:DescribeVpcEndpointConnections",
      "ec2:DescribeVpcEndpoints",
      "ec2:DescribeVpcEndpointServiceConfigurations",
      "ec2:DescribeVpcEndpointServicePermissions",
      "ec2:DescribeVpcEndpointServices",
      "ec2:DescribeVpcPeeringConnections",
      "ec2:DescribeVpcs",
      "ec2:DescribeVpnConnections",
      "ec2:DescribeVpnGateways",
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
  }
  //The following permissions are for the cluster get/put S3 bucket info and objects for logs
  statement {
    effect = "Allow"
    actions = [
      "s3:Get*",
      "s3:List*",
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

//The IAM policy document that contains the minimal permissions for EMR EC2 instances
data "aws_iam_policy_document" "emr_ec2_policy" {
  version = "2012-10-17"
  statement {
    effect = "Allow"
    actions = [
      "ec2:DescribeAccountAttributes",
      "ec2:DescribeAddresses",
      "ec2:DescribeAddressesAttribute",
      "ec2:DescribeAggregateIdFormat",
      "ec2:DescribeAvailabilityZones",
      "ec2:DescribeBundleTasks",
      "ec2:DescribeByoipCidrs",
      "ec2:DescribeCapacityReservations",
      "ec2:DescribeCarrierGateways",
      "ec2:DescribeClassicLinkInstances",
      "ec2:DescribeClientVpnAuthorizationRules",
      "ec2:DescribeClientVpnConnections",
      "ec2:DescribeClientVpnEndpoints",
      "ec2:DescribeClientVpnRoutes",
      "ec2:DescribeClientVpnTargetNetworks",
      "ec2:DescribeCoipPools",
      "ec2:DescribeConversionTasks",
      "ec2:DescribeCustomerGateways",
      "ec2:DescribeDhcpOptions",
      "ec2:DescribeEgressOnlyInternetGateways",
      "ec2:DescribeElasticGpus",
      "ec2:DescribeExportImageTasks",
      "ec2:DescribeExportTasks",
      "ec2:DescribeFastSnapshotRestores",
      "ec2:DescribeFleetHistory",
      "ec2:DescribeFleetInstances",
      "ec2:DescribeFleets",
      "ec2:DescribeFlowLogs",
      "ec2:DescribeFpgaImageAttribute",
      "ec2:DescribeFpgaImages",
      "ec2:DescribeHostReservationOfferings",
      "ec2:DescribeHostReservations",
      "ec2:DescribeHosts",
      "ec2:DescribeIamInstanceProfileAssociations",
      "ec2:DescribeIdentityIdFormat",
      "ec2:DescribeIdFormat",
      "ec2:DescribeImageAttribute",
      "ec2:DescribeImages",
      "ec2:DescribeImportImageTasks",
      "ec2:DescribeImportSnapshotTasks",
      "ec2:DescribeInstanceAttribute",
      "ec2:DescribeInstanceCreditSpecifications",
      "ec2:DescribeInstanceEventNotificationAttributes",
      "ec2:DescribeInstances",
      "ec2:DescribeInstanceStatus",
      "ec2:DescribeInstanceTypeOfferings",
      "ec2:DescribeInstanceTypes",
      "ec2:DescribeInternetGateways",
      "ec2:DescribeIpv6Pools",
      "ec2:DescribeKeyPairs",
      "ec2:DescribeLaunchTemplates",
      "ec2:DescribeLaunchTemplateVersions",
      "ec2:DescribeLocalGatewayRouteTables",
      "ec2:DescribeLocalGatewayRouteTableVirtualInterfaceGroupAssociations",
      "ec2:DescribeLocalGatewayRouteTableVpcAssociations",
      "ec2:DescribeLocalGateways",
      "ec2:DescribeLocalGatewayVirtualInterfaceGroups",
      "ec2:DescribeLocalGatewayVirtualInterfaces",
      "ec2:DescribeManagedPrefixLists",
      "ec2:DescribeMovingAddresses",
      "ec2:DescribeNatGateways",
      "ec2:DescribeNetworkAcls",
      "ec2:DescribeNetworkInsightsAnalyses",
      "ec2:DescribeNetworkInsightsPaths",
      "ec2:DescribeNetworkInterfaceAttribute",
      "ec2:DescribeNetworkInterfacePermissions",
      "ec2:DescribeNetworkInterfaces",
      "ec2:DescribePlacementGroups",
      "ec2:DescribePrefixLists",
      "ec2:DescribePrincipalIdFormat",
      "ec2:DescribePublicIpv4Pools",
      "ec2:DescribeRegions",
      "ec2:DescribeReplaceRootVolumeTasks",
      "ec2:DescribeReservedInstances",
      "ec2:DescribeReservedInstancesListings",
      "ec2:DescribeReservedInstancesModifications",
      "ec2:DescribeReservedInstancesOfferings",
      "ec2:DescribeRouteTables",
      "ec2:DescribeScheduledInstanceAvailability",
      "ec2:DescribeScheduledInstances",
      "ec2:DescribeSecurityGroupReferences",
      "ec2:DescribeSecurityGroups",
      "ec2:DescribeSnapshotAttribute",
      "ec2:DescribeSnapshots",
      "ec2:DescribeSpotDatafeedSubscription",
      "ec2:DescribeSpotFleetInstances",
      "ec2:DescribeSpotFleetRequestHistory",
      "ec2:DescribeSpotFleetRequests",
      "ec2:DescribeSpotInstanceRequests",
      "ec2:DescribeSpotPriceHistory",
      "ec2:DescribeStaleSecurityGroups",
      "ec2:DescribeStoreImageTasks",
      "ec2:DescribeSubnets",
      "ec2:DescribeTags",
      "ec2:DescribeTrafficMirrorFilters",
      "ec2:DescribeTrafficMirrorSessions",
      "ec2:DescribeTrafficMirrorTargets",
      "ec2:DescribeTransitGatewayAttachments",
      "ec2:DescribeTransitGatewayConnectPeers",
      "ec2:DescribeTransitGatewayConnects",
      "ec2:DescribeTransitGatewayMulticastDomains",
      "ec2:DescribeTransitGatewayPeeringAttachments",
      "ec2:DescribeTransitGatewayRouteTables",
      "ec2:DescribeTransitGateways",
      "ec2:DescribeTransitGatewayVpcAttachments",
      "ec2:DescribeVolumeAttribute",
      "ec2:DescribeVolumes",
      "ec2:DescribeVolumesModifications",
      "ec2:DescribeVolumeStatus",
      "ec2:DescribeVpcAttribute",
      "ec2:DescribeVpcClassicLink",
      "ec2:DescribeVpcClassicLinkDnsSupport",
      "ec2:DescribeVpcEndpointConnectionNotifications",
      "ec2:DescribeVpcEndpointConnections",
      "ec2:DescribeVpcEndpoints",
      "ec2:DescribeVpcEndpointServiceConfigurations",
      "ec2:DescribeVpcEndpointServicePermissions",
      "ec2:DescribeVpcEndpointServices",
      "ec2:DescribeVpcPeeringConnections",
      "ec2:DescribeVpcs",
      "ec2:DescribeVpnConnections",
      "ec2:DescribeVpnGateways",
      "elasticmapreduce:DescribeCluster",
      "elasticmapreduce:DescribeEditor",
      "elasticmapreduce:DescribeJobFlows",
      "elasticmapreduce:DescribeNotebookExecution",
      "elasticmapreduce:DescribeRepository",
      "elasticmapreduce:DescribeSecurityConfiguration",
      "elasticmapreduce:DescribeStep",
      "elasticmapreduce:DescribeStudio",
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
      "cloudwatch:PutMetricData",
      "s3:HeadBucket",
    ]
    resources = [
      "*",
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
  policy = data.aws_iam_policy_document.emr_ec2_policy.json
}

//The IAM role policy attachment that attaches the minimal policy to the IAM role
resource "aws_iam_role_policy_attachment" "emr_ec2_instance_profile" {
  role       = aws_iam_role.emr_ec2_instance_profile.name
  policy_arn = aws_iam_policy.emr_ec2_iam_policy.arn
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
