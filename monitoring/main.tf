terraform {
  required_providers {
    aws = {
      source  = "hashicorp/aws"
      version = "~> 4.16"
    }
  }
  required_version = ">= 1.2.0"
}

provider "aws" {
  region = "eu-west-3"
}

resource "aws_instance" "app_server" {
  ami           = "ami-087da76081e7685da"
  instance_type = "t2.micro"
  key_name      = aws_key_pair.monitoring-key.key_name

  vpc_security_group_ids = [aws_security_group.default.id]

  tags = {
    Name = "monitoring-final-project"
  }
}

resource "aws_key_pair" "monitoring-key" {
  key_name   = "monitoring-key"
  public_key = file("~/.ssh/monitoring-key.pub")
}

# Create a security group for the instances
resource "aws_security_group" "default" {
  name        = "terraform-example"
  description = "Used in the terraform"

  # SSH access
  ingress {
    from_port   = 22
    to_port     = 22
    protocol    = "tcp"
    cidr_blocks = ["82.66.82.21/32"]
  }

  # HTTP access
  ingress {
    from_port   = 80
    to_port     = 80
    protocol    = "tcp"
    cidr_blocks = ["0.0.0.0/0"]
  }

  # HTTPS access
  ingress {
    from_port   = 443
    to_port     = 443
    protocol    = "tcp"
    cidr_blocks = ["0.0.0.0/0"]
  }

  # outbound internet access
  # Disable after installation Parce que sinon ça va PETER, PETER !! https://www.youtube.com/watch?v=Xptd4gb3FHc
  egress {
    from_port   = 0
    to_port     = 0
    protocol    = "-1"
    cidr_blocks = ["0.0.0.0/0"]
  }
}
