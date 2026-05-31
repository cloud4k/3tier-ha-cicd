resource "aws_launch_template" "frontend" {
  name_prefix   = "${var.project_name}-${var.environment}-frontend-"
  image_id      = var.ami_id
  instance_type = var.instance_type

  iam_instance_profile {
    name = var.instance_profile_name
  }

  vpc_security_group_ids = [var.frontend_sg_id]

  user_data = base64encode(
    file("${path.module}/../../scripts/frontend-ec2-userdata.sh")
  )

  tag_specifications {
    resource_type = "instance"

    tags = {
      Name = "${var.project_name}-${var.environment}-frontend"
    }
  }
}

resource "aws_autoscaling_group" "frontend" {
  name = "${var.project_name}-${var.environment}-frontend-asg"

  desired_capacity = 2
  min_size         = 2
  max_size         = 4

  vpc_zone_identifier = [
    var.private_app_subnet_az1_id,
    var.private_app_subnet_az2_id
  ]

  target_group_arns = [
    var.frontend_target_group_arn
  ]

  launch_template {
    id      = aws_launch_template.frontend.id
    version = "$Latest"
  }

  health_check_type         = "ELB"
  health_check_grace_period = 300

  tag {
    key                 = "Name"
    value               = "${var.project_name}-${var.environment}-frontend"
    propagate_at_launch = true
  }
}