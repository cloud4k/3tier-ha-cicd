output "vpc_id" {
  value = aws_vpc.this.id
}

output "public_subnet_az1_id" {
  value = aws_subnet.public_az1.id
}

output "public_subnet_az2_id" {
  value = aws_subnet.public_az2.id
}

output "private_app_subnet_az1_id" {
  value = aws_subnet.private_app_az1.id
}

output "private_app_subnet_az2_id" {
  value = aws_subnet.private_app_az2.id
}

output "private_db_subnet_az1_id" {
  value = aws_subnet.private_db_az1.id
}

output "private_db_subnet_az2_id" {
  value = aws_subnet.private_db_az2.id
}