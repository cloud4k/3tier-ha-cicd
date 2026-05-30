aws_region = "us-east-1"

project_name = "3tier-ha-cicd"
environment  = "dev-ec2"

vpc_cidr = "10.0.0.0/16"

public_subnet_az1_cidr = "10.0.1.0/24"
public_subnet_az2_cidr = "10.0.2.0/24"

private_app_subnet_az1_cidr = "10.0.11.0/24"
private_app_subnet_az2_cidr = "10.0.12.0/24"

private_db_subnet_az1_cidr = "10.0.21.0/24"
private_db_subnet_az2_cidr = "10.0.22.0/24"

az1     = "us-east-1a"
az2     = "us-east-1b"
db_name = "appdb"

db_username = "admin"

db_password = "ChangeThisPassword123!"

db_instance_class = "db.t3.micro"

allocated_storage = 20

instance_type = "t3.large"
