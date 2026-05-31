output "vpc_id" {
  value = module.vpc.vpc_id
}
output "db_endpoint" {
  value = module.rds.db_endpoint
}

output "db_name" {
  value = module.rds.db_name
}
output "alb_dns_name" {
  value = module.alb.alb_dns_name
}
output "backend_launch_template_id" {
  value = module.ec2_backend.launch_template_id
}

output "backend_autoscaling_group_name" {
  value = module.ec2_backend.autoscaling_group_name
}
output "frontend_launch_template_id" {
  value = module.ec2_frontend.launch_template_id
}

output "frontend_autoscaling_group_name" {
  value = module.ec2_frontend.autoscaling_group_name
}
output "artifact_bucket_name" {
  value = module.s3_artifacts.bucket_name
}