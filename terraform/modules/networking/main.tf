module "networking" {
  source = "./vpc"

  name        = var.name
  environment = var.environment

  cidr_block = var.vpc_base_cidr

  common_tags = var.common_tags
}
