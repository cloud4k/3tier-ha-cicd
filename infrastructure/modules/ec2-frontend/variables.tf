variable "project_name" {
  type = string
}

variable "environment" {
  type = string
}

variable "ami_id" {
  type = string
}

variable "instance_type" {
  type = string
}

variable "private_app_subnet_az1_id" {
  type = string
}

variable "private_app_subnet_az2_id" {
  type = string
}

variable "frontend_sg_id" {
  type = string
}

variable "frontend_target_group_arn" {
  type = string
}
variable "instance_profile_name" {
  type = string
}