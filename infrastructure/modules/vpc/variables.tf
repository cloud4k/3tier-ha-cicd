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