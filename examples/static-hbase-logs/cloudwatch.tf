resource "aws_cloudwatch_log_group" "tamr_log_group" {
  name = format("%s-%s", var.name_prefix, "tamr_log_group")
  tags = var.tags
}

# Get current Region
data "aws_region" "current" {}

resource "local_file" "postfix_config" {
  filename = "./files/cloudwatch-install.sh"
  content  = templatefile("./files/cloudwatch-install.tpl", { region = data.aws_region.current.name, endpoint = module.endpoints.endpoints["logs"].dns_entry[0]["dns_name"], log_group = aws_cloudwatch_log_group.tamr_log_group.name })
}
