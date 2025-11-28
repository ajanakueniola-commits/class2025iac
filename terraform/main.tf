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
  region = "us-east-2"
}


resource "aws_instance" "nginx-node" {
  ami                    = "ami-0911b851aa587d484"
  instance_type          = "c7i-flex.large"
  subnet_id              = "subnet-05321b19c9d5946ea"
  vpc_security_group_ids = ["sg-09d236d4e61ec5a23"]
  key_name               = "ohio123"

  tags = {
    Name = "terraform-nginx-node"
  }
}

resource "aws_instance" "java-node" {
  ami                    = "ami-09e135f9b497eb5f4"
  instance_type          = "c7i-flex.large"
  subnet_id              = "subnet-05321b19c9d5946ea"
  vpc_security_group_ids = ["sg-0ccabcb016706b9d9"]
  key_name               = "ohio123"

  tags = {
    Name = "terraform-java-node"
  }
}


resource "aws_instance" "python-node" {
  ami                    = "ami-034533e91587906ce"
  instance_type          = "c7i-flex.large"
  subnet_id              = "subnet-05321b19c9d5946ea"
  vpc_security_group_ids = ["sg-0942d9102d79e3c75"]
  key_name               = "ohio123"

  tags = {
    Name = "terraform-python-node"
  }
}
