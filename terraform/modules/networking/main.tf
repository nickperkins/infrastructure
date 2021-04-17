module "networking" {
  source = "./vpc"

  cidr_block = var.vpc_base_cidr

  common_tags = var.common_tags
}
