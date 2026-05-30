variable "aws_region" {
  type = string
}

variable "project_name" {
  type = string
}

variable "environment" {
  type = string
}

variable "vpc_cidr" {
  type = string
}

variable "public_subnet_az1_cidr" {
  type = string
}

variable "public_subnet_az2_cidr" {
  type = string
}

variable "private_app_subnet_az1_cidr" {
  type = string
}

variable "private_app_subnet_az2_cidr" {
  type = string
}

variable "private_db_subnet_az1_cidr" {
  type = string
}

variable "private_db_subnet_az2_cidr" {
  type = string
}

variable "az1" {
  type = string
}

variable "az2" {
  type = string
}
variable "db_name" {
  type = string
}

variable "db_username" {
  type = string
}

variable "db_password" {
  type      = string
  sensitive = true
}

variable "db_instance_class" {
  type = string
}

variable "allocated_storage" {
  type = number
}

variable "instance_type" {
  type = string
}