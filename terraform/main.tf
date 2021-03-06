module "development_network" {
  count = terraform.workspace == "development" ? 1 : 0

  source = "./modules/networking"

  name          = "main"
  environment   = terraform.workspace
  vpc_base_cidr = "10.1.0.0/16"

  default_tags = local.default_tags

}
