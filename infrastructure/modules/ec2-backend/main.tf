resource "aws_launch_template" "backend" {
  name_prefix   = "${var.project_name}-${var.environment}-backend-"
  image_id      = var.ami_id
  instance_type = var.instance_type

  iam_instance_profile {
    name = var.instance_profile_name
  }

  vpc_security_group_ids = [var.backend_sg_id]

  user_data = base64encode(file("${path.module}/../../scripts/backend-ec2-userdata.sh"))

  tag_specifications {
    resource_type = "instance"

    tags = {
      Name = "${var.project_name}-${var.environment}-backend"
    }
  }
}

resource "aws_autoscaling_group" "backend" {
  name = "${var.project_name}-${var.environment}-backend-asg"

  desired_capacity = 2
  min_size         = 2
  max_size         = 4

  vpc_zone_identifier = [
    var.private_app_subnet_az1_id,
    var.private_app_subnet_az2_id
  ]

  target_group_arns = [var.backend_target_group_arn]

  launch_template {
    id      = aws_launch_template.backend.id
    version = "$Latest"
  }

  health_check_type         = "ELB"
  health_check_grace_period = 300

  tag {
    key                 = "Name"
    value               = "${var.project_name}-${var.environment}-backend"
    propagate_at_launch = true
  }
}