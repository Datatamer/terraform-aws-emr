# Tamr AWS EMRFS Terraform Module
This terraform module creates a dynamodb table for EMRFS

# Examples
## Basic
Inline example implementation of the module.  This is the most basic example of what it would look like to use this module.
```
module "emrfs-table" {
  source                    = "git::git@github.com:Datatamer/terraform-aws-emr.git/modules/aws-emr-emrfs?ref=0.11.1"
  emrfs_metadata_table_name = "example-emrfs-table"
}
```

# Resources Created
This terraform module creates:
* 1 dynamodb table for EMRFS

<!-- BEGINNING OF PRE-COMMIT-TERRAFORM DOCS HOOK -->
## Requirements

| Name | Version |
|------|---------|
| terraform | >= 0.12 |
| aws | >= 2.45.0 |

## Providers

| Name | Version |
|------|---------|
| aws | >= 2.45.0 |
| time | n/a |

## Inputs

| Name | Description | Type | Default | Required |
|------|-------------|------|---------|:--------:|
| create\_static\_cluster | True if the module should create a static cluster. False if the module should create supporting infrastructure but not the cluster itself. | `bool` | `true` | no |
| emrfs\_metadata\_read\_capacity | Read capacity units of the DynamoDB table used for EMRFS metadata | `number` | `600` | no |
| emrfs\_metadata\_table\_name | Table name of EMRFS metadata table in DynamoDB | `string` | `"EmrFSMetadata"` | no |
| emrfs\_metadata\_write\_capacity | Write capacity units of the DynamoDB table used for EMRFS metadata | `number` | `300` | no |
| tags | Additional tags to be attached to the DynamoDB table | `map(string)` | `{}` | no |

## Outputs

| Name | Description |
|------|-------------|
| emrfs\_dynamodb\_table\_id | ID for the emrfs dynamodb table |
| emrfs\_dynamodb\_table\_name | Name for the emrfs dynamodb table |

<!-- END OF PRE-COMMIT-TERRAFORM DOCS HOOK -->

# Reference documents:
* AWS EMRFS Consistent View: https://docs.aws.amazon.com/emr/latest/ManagementGuide/emrfs-files-tracked.html
* Terraform module structure: https://www.terraform.io/docs/modules/index.html#standard-module-structure
