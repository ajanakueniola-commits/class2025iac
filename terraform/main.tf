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
  ami                    = "ami-0fc5e0bb86da78304"
  instance_type          = "c7i-flex.large"
  subnet_id              = "subnet-05321b19c9d5946ea"
  vpc_security_group_ids = ["sg-09d236d4e61ec5a23"]
  key_name               = "ohio123"

  tags = {
    Name = "terraform-nginx-node"
  }
}

resource "aws_instance" "java-node" {
  ami                    = "ami-0433c3cc52cc22db0"
  instance_type          = "c7i-flex.large"
  subnet_id              = "subnet-05321b19c9d5946ea"
  vpc_security_group_ids = ["sg-09d236d4e61ec5a23"]
  key_name               = "ohio123"

  tags = {
    Name = "terraform-java-node"
  }
}


resource "aws_instance" "python-node" {
  ami                    = "ami-0da65d921c0beda88"
  instance_type          = "c7i-flex.large"
  subnet_id              = "subnet-05321b19c9d5946ea"
  vpc_security_group_ids = ["sg-09d236d4e61ec5a23"]
  key_name               = "ohio123"

  tags = {
    Name = "terraform-python-node"
  }
}
