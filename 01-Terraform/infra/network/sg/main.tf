/* 디폴트 보안 그룹
  resource "aws_default_security_group" "aws02_default_sg" {
  vpc_id = data.terraform_remote_state.aws02_vpc.outputs.vpc_id

  ingress {
    protocol    = "tcp"
    from_port   = 0
    to_port     = 65535
    cidr_blocks = [data.terraform_remote_state.aws02_vpc.outputs.vpc_cidr]
  }

  egress {
    protocol    = "-1"
    from_port   = 0
    to_port     = 0
    cidr_blocks = ["0.0.0.0/0"]
  }

  tags = {
    Name        = "aws02_default_sg"
    Description = "default security group"
  }
}
*/

# SSH Security group
resource "aws_security_group" "aws02_ssh_sg" {
    name = "aws02_ssh_sg"
    description = "security group for ssh server"
    vpc_id = data.terraform_remote_state.aws02_vpc.outputs.vpc_id

  ingress {
    description = "For ssh port"
    protocol    = "tcp"
    from_port   = 22
    to_port     = 22
    cidr_blocks = ["0.0.0.0/0"]
  }

  egress {
    protocol    = "-1"
    from_port   = 0
    to_port     = 0
    cidr_blocks = ["0.0.0.0/0"]
  }

  tags = {
    Name        = "aws02_ssh_sg"
  }
}

# WEP Security group
resource "aws_security_group" "aws02_wep_sg" {
    name = "aws02_wep_sg"
    description = "security group for wep server"
    vpc_id = data.terraform_remote_state.aws02_vpc.outputs.vpc_id

  ingress {
    description = "For wep port"
    protocol    = "tcp"
    from_port   = 80
    to_port     = 80
    cidr_blocks = ["0.0.0.0/0"]
  }

  egress {
    protocol    = "-1"
    from_port   = 0
    to_port     = 0
    cidr_blocks = ["0.0.0.0/0"]
  }

  tags = {
    Name        = "aws02_wep_sg"
  }
}