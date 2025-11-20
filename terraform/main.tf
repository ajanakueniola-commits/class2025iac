terraform {
  required_version = ">= 1.6.0"

  required_providers {
    aws = {
      source  = "hashicorp/aws"
      version = "~> 5.0"
    }
  }
}

provider "aws" {
  region = "eu-west-1"
}


resource "aws_instance" "nginx-node" {
  ami                    = "ami-04b0f804b92257917"
  instance_type          = "t3.micro"
  subnet_id              = "subnet-07c33c12d2fe680e4"
  vpc_security_group_ids = ["sg-02182a0158d86e8a6"]
  key_name               = "xxxxxxxx"

  tags = {
    Name = "terraform-nginx-node"
  }
}

resource "aws_instance" "java-node" {
  ami                    = "ami-0f772da681fe60799"
  instance_type          = "t3.micro"
  subnet_id              = "subnet-07c33c12d2fe680e4"
  vpc_security_group_ids = ["sg-02182a0158d86e8a6"]
  key_name               = "xxxxxxxx"

  tags = {
    Name = "terraform-java-node"
  }
}


resource "aws_instance" "python-node" {
  ami                    = "ami-0d89bf3a575c72b02"
  instance_type          = "t3.micro"
  subnet_id              = "subnet-07c33c12d2fe680e4"
  vpc_security_group_ids = ["sg-02182a0158d86e8a6"]
  key_name               = "xxxxxxxxxxxx"

  tags = {
    Name = "terraform-python-node"
  }
}
