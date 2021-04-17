locals {
  environment = terraform.workspace

  default_tags = {
    Environment = "${local.environment}"
  }
}
