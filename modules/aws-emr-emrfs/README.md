# Tamr AWS EMR HBase Terraform Module
This terraform module creates a dynamodb table for EMRFS

# Example
main.tf:
```
module "emrfs-table" {
  source = "git::git@github.com:Datatamer/terraform-emr-hbase.git/modules/aws-emr-emrfs?ref=0.5.0"
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

## Providers

| Name | Version |
|------|---------|
| aws | n/a |
| time | n/a |

## Inputs

| Name | Description | Type | Default | Required |
|------|-------------|------|---------|:--------:|
| emrfs\_metadata\_read\_capacity | Read capacity units of the dynamodb table used for EMRFS metadata | `number` | `600` | no |
| emrfs\_metadata\_table\_name | Table name of the dynamodb table for EMRFS metadata | `string` | `"EmrFSMetadata"` | no |
| emrfs\_metadata\_write\_capacity | Write capacity units of the dynamodb table used for EMRFS metadata | `number` | `300` | no |
| tags | Map of tags | `map(string)` | `{}` | no |

## Outputs

| Name | Description |
|------|-------------|
| tamr\_emr\_cluster\_id | Identifier for the AWS EMR cluster created |

<!-- END OF PRE-COMMIT-TERRAFORM DOCS HOOK -->

# Reference documents:
* AWS EMRFS Consistent View: https://docs.aws.amazon.com/emr/latest/ManagementGuide/emrfs-files-tracked.html
* Terraform module structure: https://www.terraform.io/docs/modules/index.html#standard-module-structure

