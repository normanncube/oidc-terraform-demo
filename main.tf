module "vpc" {
  source       = "./modules/ifra"
  project_name = var.project_name
  vpc_cidr     = var.vpc_cidr
  #aws_region   = var.aws_region
}

