resource "aws_cloudwatch_log_group" "tamr_log_group" {
  name = format("%s-%s", var.name_prefix, "tamr_log_group")
  tags = var.tags
}

# Get current Region
data "aws_region" "current" {}

resource "local_file" "cloudwatch-install" {
  filename = "${path.module}/tempfiles/cloudwatch-install-spark.sh"
  content  = templatefile("../files/cloudwatch-install-spark.tpl", { region = data.aws_region.current.name, endpoint = var.vpce_logs_endpoint_dnsname, log_group = aws_cloudwatch_log_group.tamr_log_group.name })
}
