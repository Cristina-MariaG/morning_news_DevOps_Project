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

resource "aws_instance" "miksiei" {
  ami           = "ami-087da76081e7685da"
  instance_type = "t2.micro"
  key_name = "miksiei-projetfinal"
  security_groups = ["miksiei-sg"]
  tags = {
    Name = "miksiei"
  }
}

resource "aws_iam_user" "Bastien" {
  name = "Bastien"
}

resource "aws_iam_user_policy_attachment" "admin_bastien" {
  user = aws_iam_user.Bastien.name
  policy_arn = "arn:aws:iam::aws:policy/AdministratorAccess"
}

resource "aws_iam_access_key" "Bastien" {
  user = aws_iam_user.Bastien.name
}

resource "aws_iam_user" "Cristina" {
  name = "Cristina"
}

resource "aws_iam_user_policy_attachment" "admin_cristina" {
  user = aws_iam_user.Cristina.name
  policy_arn = "arn:aws:iam::aws:policy/AdministratorAccess"
}

resource "aws_iam_access_key" "Cristina" {
  user = aws_iam_user.Cristina.name
}