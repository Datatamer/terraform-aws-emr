# Tamr AWS EMR Ports Module
This module returns a list of ports used by the EMR Service.

# Resources Created
This module creates no resources.

<!-- BEGINNING OF PRE-COMMIT-TERRAFORM DOCS HOOK -->
## Requirements

No requirements.

## Providers

No provider.

## Inputs

| Name | Description | Type | Default | Required |
|------|-------------|------|---------|:--------:|
| applications | List of applications to run on EMR | `list(string)` | n/a | yes |
| additional\_ports | Additional ports to add to the output of this module | `list(number)` | `[]` | no |
| core\_ports\_emr\_6x | Ports used by AWS EMR Core 6x | `list(number)` | <pre>[<br>  9864<br>]</pre> | no |
| core\_ports\_emr\_pre\_6x | Ports used by AWS EMR Core pre-6x | `list(number)` | <pre>[<br>  50010,<br>  50075<br>]</pre> | no |
| core\_ports\_hbase | Ports used by AWS EMR Core HBase | `list(number)` | <pre>[<br>  16020,<br>  16030<br>]</pre> | no |
| core\_ports\_spark | Ports used by AWS EMR Core Spark | `list(number)` | <pre>[<br>  8042<br>]</pre> | no |
| is\_pre\_6x | Is this a pre-6x EMR | `bool` | `true` | no |
| master\_ports\_emr | Ports used by AWS EMR | `list(number)` | <pre>[<br>  8443<br>]</pre> | no |
| master\_ports\_ganglia | Ports used by Ganglia | `list(number)` | <pre>[<br>  80<br>]</pre> | no |
| master\_ports\_hbase\_6x | Ports used by AWS EMR Master HBase post-6.x | `list(number)` | <pre>[<br>  9870<br>]</pre> | no |
| master\_ports\_hbase\_common | Common ports used by AWS EMR Master HBase | `list(number)` | <pre>[<br>  2181,<br>  8020,<br>  8070,<br>  8085,<br>  9090,<br>  9095,<br>  16000,<br>  16010<br>]</pre> | no |
| master\_ports\_hbase\_pre\_6x | Ports used by AWS EMR Master HBase pre-6.x | `list(number)` | <pre>[<br>  50070<br>]</pre> | no |
| master\_ports\_spark | Ports used by AWS EMR Master Spark | `list(number)` | <pre>[<br>  8088,<br>  18080,<br>  19888,<br>  20888<br>]</pre> | no |
| service\_access\_ports | Ports used by AWS Service Access | `list(number)` | <pre>[<br>  22,<br>  9443<br>]</pre> | no |

## Outputs

| Name | Description |
|------|-------------|
| ingress\_core\_ports | List of ingress core ports |
| ingress\_master\_ports | List of ingress master ports |
| ingress\_service\_access\_ports | List of service access ports |

<!-- END OF PRE-COMMIT-TERRAFORM DOCS HOOK -->

# References
This repo is based on:
* [terraform standard module structure](https://www.terraform.io/docs/modules/index.html#standard-module-structure)
* [templated terraform module](https://github.com/tmknom/template-terraform-module)

# License
Apache 2 Licensed. See LICENSE for full details.
