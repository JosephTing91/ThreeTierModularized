


resource "aws_instance" "bastion" {
  ami             = var.ami_id_master #ubuntu ami
  instance_type   = "t2.micro"
  vpc_security_group_ids = [var.bastionsg_id]
  key_name        = var.key_name
  iam_instance_profile = var.instance_profile_name
  
  associate_public_ip_address = true
  subnet_id = var.pubsubnet1_id
    tags = {
    Name = "Ansible-Control-Node"
  }
  user_data = filebase64("ansible_control_node.sh")
}


resource "aws_launch_template" "webserver-LT" {
  name = "webserver-LT"

  iam_instance_profile {
    name = var.instance_profile_name 
  }
  image_id = var.ami_id_managed[var.region]
  instance_initiated_shutdown_behavior = "terminate"
  instance_type = "t2.micro"
  key_name = var.key_name

  network_interfaces {
    associate_public_ip_address = true
    security_groups = [var.webinstancesg_id]
  }

  tag_specifications {
    resource_type = "instance"
    tags = {
      Name = "web-tier instance"
      Env  = "web"
    }
  }
  #user_data = filebase64("webserver_user_data.sh")

}


resource "aws_launch_template" "appserver-LT" {
  name = "appserver-LT"

  iam_instance_profile {
    name = var.instance_profile_name 
  }
  image_id = var.ami_id_managed[var.region]
  instance_initiated_shutdown_behavior = "terminate"
  instance_type = "t2.micro"
  key_name = var.key_name

  network_interfaces {
    associate_public_ip_address = true
    security_groups = [var.appinstancesg_id]
  }

  tag_specifications {
    resource_type = "instance"
    tags = {
      Name = "app-tier instance"
      Env  = "app"
    }
  }
  #user_data = filebase64("app_user_data.sh")


}

resource "aws_autoscaling_group" "web-asg" {
  name                      = "web-asg"
  max_size                  = 4
  min_size                  = 2
  health_check_grace_period = 300
  desired_capacity          = 2
  vpc_zone_identifier       = [var.pubsubnet1_id, var.pubsubnet2_id]
  target_group_arns         = [var.public-lb-tg-arn]
  launch_template {
      id = aws_launch_template.webserver-LT.id
     version= "$Latest"
     }

}
resource "aws_autoscaling_group" "app-asg" {
  name                      = "app-asg"
  max_size                  = 4
  min_size                  = 2
  health_check_grace_period = 300
  desired_capacity          = 2
  vpc_zone_identifier       = [var.privsubnet1_id, var.privsubnet2_id]
  target_group_arns         = [var.private-lb-tg-arn]
  launch_template {
      id = aws_launch_template.appserver-LT.id
     version= "$Latest"
     }

}