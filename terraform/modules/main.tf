module "networking" {
  source = "./networking"

  name        = var.name
  environment = var.environment

  cidr_block = var.vpc_base_cidr

  default_tags = var.default_tags
}
