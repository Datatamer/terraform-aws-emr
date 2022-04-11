resource "aws_cloudwatch_log_group" "tamr_log_group" {
  name = format("%s-%s", var.name_prefix, "tamr_log_group")
  tags = var.tags
}

# Get current Region
data "aws_region" "current" {}

resource "local_file" "postfix_config" {
  filename = "${path.module}/files/cloudwatch-install.sh"
  content  = templatefile("${path.module}/files/cloudwatch-install.tpl", { region = data.aws_region.current.name, endpoint = var.vpce_logs_endpoint_dnsname, log_group = aws_cloudwatch_log_group.tamr_log_group.name })
}
