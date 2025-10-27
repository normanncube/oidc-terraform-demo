module "vpc" {
  source       = "./modules/ifra"
  project_name = var.project_name
  vpc_cidr     = var.vpc_cidr
  #aws_region   = var.aws_region
}

module "security_groups" {
  source       = "./modules/compute"
  vpc_id       = module.vpc.vpc_id
  subnet_id    = module.vpc.public_subnet_ids[0]
}
module "ec2_instances" {
  source       = "./modules/compute"
  subnet_id    = module.vpc.public_subnet_ids[0]
  vpc_id       = module.vpc.vpc_id

}





