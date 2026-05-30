terraform {
  backend "s3" {
    bucket         = "harjotscloud-shared-terraform-state"
    key            = "3tier-ha-cicd/dev-ec2/terraform.tfstate"
    region         = "us-east-1"
    dynamodb_table = "harjotscloud-shared-terraform-locks"
    encrypt        = true
  }
}