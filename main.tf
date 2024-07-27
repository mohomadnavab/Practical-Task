#Provider.tf

terraform {
  required_providers {
    aws = {
      source = "hashicorp/aws"
      version = "5.60.0"
    }
  }
}
provider "aws" {
  region = "ap-south-1" 
}

#main.tf

resource "aws_vpc" "web_vpc" {
  cidr_block = "10.0.0.0/16"

  tags = {
    Name = "web_app_vpc"
  }
}

resource "aws_subnet" "public_1" {
  vpc_id     = aws_vpc.web_vpc.id
  cidr_block = "10.0.1.0/24"

  tags = {
    Name = "public_1"
  }
}

resource "aws_security_group" "web_sg" {
  name        = "web_app_sg"
  description = "Allow SSH and HTTP traffic"
  vpc_id      = aws_vpc.web_vpc.id

  ingress {
    from_port   = 22
    to_port     = 22
    protocol    = "tcp"
    cidr_blocks = ["0.0.0.0/0"]
  }

  ingress {
    from_port   = 80
    to_port     = 80
    protocol    = "tcp"
    cidr_blocks = ["0.0.0.0/0"]
  }
}

resource "aws_instance" "web_app" {
  ami           = "ami-0c2af51e265bd5e0e"  
  instance_type = "t2.micro"
  key_name      = "terraform-key"
  subnet_id     = aws_subnet.public_1.id
  vpc_security_group_ids = [aws_security_group.web_sg.id]
  associate_public_ip_address = true

  tags = {
    Name = "server-1"
  }
}
