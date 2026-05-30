terraform {
  required_version = ">= 1.5.0"

  required_providers {
    aws = {
      source  = "hashicorp/aws"
      version = "~> 5.0"
    }
  }
}

provider "aws" {
  region = var.aws_region
}
data "aws_ami" "amazon_linux_2023" {
  most_recent = true
  owners      = ["amazon"]

  filter {
    name   = "name"
    values = ["al2023-ami-*-x86_64"]
  }

  filter {
    name   = "state"
    values = ["available"]
  }
}
module "vpc" {
  source = "../../modules/vpc"

  project_name = var.project_name
  environment  = var.environment

  vpc_cidr = var.vpc_cidr

  public_subnet_az1_cidr = var.public_subnet_az1_cidr
  public_subnet_az2_cidr = var.public_subnet_az2_cidr

  private_app_subnet_az1_cidr = var.private_app_subnet_az1_cidr
  private_app_subnet_az2_cidr = var.private_app_subnet_az2_cidr

  private_db_subnet_az1_cidr = var.private_db_subnet_az1_cidr
  private_db_subnet_az2_cidr = var.private_db_subnet_az2_cidr

  az1 = var.az1
  az2 = var.az2
}
module "security_groups" {
  source = "../../modules/security-groups"

  project_name = var.project_name
  environment  = var.environment
  vpc_id       = module.vpc.vpc_id
}
module "rds" {
  source = "../../modules/rds"

  project_name = var.project_name
  environment  = var.environment

  private_db_subnet_az1_id = module.vpc.private_db_subnet_az1_id
  private_db_subnet_az2_id = module.vpc.private_db_subnet_az2_id

  database_sg_id = module.security_groups.database_sg_id

  db_name           = var.db_name
  db_username       = var.db_username
  db_password       = var.db_password
  db_instance_class = var.db_instance_class
  allocated_storage = var.allocated_storage
}
module "alb" {
  source = "../../modules/alb"

  project_name = var.project_name
  environment  = var.environment

  vpc_id = module.vpc.vpc_id

  public_subnet_az1_id = module.vpc.public_subnet_az1_id
  public_subnet_az2_id = module.vpc.public_subnet_az2_id

  alb_sg_id = module.security_groups.alb_sg_id
}
module "ec2_backend" {
  source = "../../modules/ec2-backend"

  project_name = var.project_name
  environment  = var.environment

  ami_id        = data.aws_ami.amazon_linux_2023.id
  instance_type = var.instance_type

  private_app_subnet_az1_id = module.vpc.private_app_subnet_az1_id
  private_app_subnet_az2_id = module.vpc.private_app_subnet_az2_id

  backend_sg_id = module.security_groups.backend_sg_id

  backend_target_group_arn = module.alb.backend_target_group_arn
}
module "ec2_frontend" {
  source = "../../modules/ec2-frontend"

  project_name = var.project_name
  environment  = var.environment

  ami_id        = data.aws_ami.amazon_linux_2023.id
  instance_type = var.instance_type

  private_app_subnet_az1_id = module.vpc.private_app_subnet_az1_id
  private_app_subnet_az2_id = module.vpc.private_app_subnet_az2_id

  frontend_sg_id = module.security_groups.frontend_sg_id

  frontend_target_group_arn = module.alb.frontend_target_group_arn
}