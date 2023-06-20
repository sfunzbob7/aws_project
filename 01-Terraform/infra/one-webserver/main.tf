provider "aws" {
  region = "ap-northeast-2"
}

resource "aws_instance" "example" {
  ami           = "ami-0c6e5afdd23291f73"
  instance_type = "t2.micro"
  vpc_security_group_ids = [aws_security_group.instance.id] 

  user_data = <<-EOF
              #!/bin/bash
              echo "Hello, World" > index.html
              nohup busybox httpd -f -p ${var.server_port} &
              EOF
  # tags 추가
  tags = {
    Name = "aws00-example"
  }
}

resource "aws_security_group" "instance" {
  name = "aws00-terrafrom-example-instance"
  
  ingress {
    from_port    = var.server_port
    to_port      = var.server_port
    protocol     = "tcp"
    cidr_blocks   = ["0.0.0.0/0"]
  }
}

output "public_ip" {
  value       = aws_instance.example.public_ip
  description = "The public IP of the Instance"
}

variable "server_port" {
  description = "The port will use for HTTP requests"
  type        = number
}









