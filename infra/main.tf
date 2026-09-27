locals {
  tags = {
    Project = var.project_name
    Course  = "DevOps-2026.2"
    Managed = "terraform"
  }
}

module "vpc" {
  source = "./modules/vpc"

  name = var.project_name
  azs  = var.azs
  tags = local.tags
}

module "security_group" {
  source = "./modules/security-group"

  name   = var.project_name
  vpc_id = module.vpc.vpc_id
  tags   = local.tags
}

module "rds" {
  source = "./modules/rds"

  name               = var.project_name
  private_subnet_ids = module.vpc.private_subnet_ids
  security_group_id  = module.security_group.rds_sg_id
  db_name            = var.db_name
  db_username        = var.db_username
  db_password        = var.db_password
  tags               = local.tags
}

module "ec2" {
  source = "./modules/ec2"

  name              = var.project_name
  public_subnet_id  = module.vpc.public_subnet_ids[0]
  security_group_id = module.security_group.ec2_sg_id
  repo_url          = var.repo_url
  db_host           = module.rds.address
  db_port           = module.rds.port
  db_user           = var.db_username
  db_password       = var.db_password
  db_name           = var.db_name
  tags              = local.tags
}
