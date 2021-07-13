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
| additional\_ports | Additional ports to add to the output of this module | `list(number)` | `[]` | no |
| core\_ports | Ports used by AWS EMR Core | `list(number)` | <pre>[<br>  8042,<br>  50010,<br>  50075<br>]</pre> | no |
| master\_ports | Ports used by AWS EMR Master | `list(number)` | <pre>[<br>  80,<br>  2181,<br>  8020,<br>  8070,<br>  8085,<br>  8088,<br>  8443,<br>  9090,<br>  9095,<br>  16000,<br>  16010,<br>  16020,<br>  16030,<br>  18080,<br>  19888,<br>  20888,<br>  50070<br>]</pre> | no |

## Outputs

| Name | Description |
|------|-------------|
| ingress\_core\_ports | List of ingress core ports |
| ingress\_master\_ports | List of ingress master ports |

<!-- END OF PRE-COMMIT-TERRAFORM DOCS HOOK -->

# References
This repo is based on:
* [terraform standard module structure](https://www.terraform.io/docs/modules/index.html#standard-module-structure)
* [templated terraform module](https://github.com/tmknom/template-terraform-module)

# License
Apache 2 Licensed. See LICENSE for full details.
