provider "aws" {
  region = "ap-northeast-2"
}

# AWS 시작템플릿 생성
resource "aws_launch_template" "example" {
  name                   = "aws02-example"
  image_id               = "ami-0c6e5afdd23291f73"
  instance_type          = "t2.micro"
  key_name               = "aws02-key"
  vpc_security_group_ids = [aws_security_group.instance.id]

  user_data = base64encode(data.template_file.web_output.rendered)

  lifecycle {
    create_before_destroy = true
  }
}

# AWS auto scaling group 생성
resource "aws_autoscaling_group" "example" {
  # subnet 지정
  vpc_zone_identifier = [var.subnet_public_1, var.subnet_public_2]

  name             = "aws02-terraform-asg-example"
  desired_capacity = 1
  min_size         = 1
  max_size         = 2

  launch_template {
    id      = aws_launch_template.example.id
    version = "$Latest"
  }
  tag {
    key                 = "Name"
    value               = "aws02-terraform-asg-example"
    propagate_at_launch = true
  }
}

resource "aws_security_group" "instance" {
  name   = "aws02-terraform-example-instance"
  vpc_id = var.vpc_id

  ingress {
    from_port   = var.server_port
    to_port     = var.server_port
    protocol    = "tcp"
    cidr_blocks = ["0.0.0.0/0"]
  }
}

data "template_file" "web_output" {
  template = file("${path.module}/web.sh")
  vars = {
    server_port = "${var.server_port}"
  }
}

variable "vpc_id" {
  default = "<vpc-id>"
}

variable "subnet_public_1" {
  default = "<subnet-id>"
}

variable "subnet_public_2" {
  default = "<subnet-id>"
}

variable "server_port" {
  description = "The port will use for HTTP requests"
  type        = number
  default     = 8080
}
