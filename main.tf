module "vpc" {
  source = "./modules/vpc"

  name           = var.name
  environment    = var.environment
  vpc_cidr       = var.vpc_cidr
  public_subnet  = var.public_subnet
  private_subnet = var.private_subnet
  region = var.region
}