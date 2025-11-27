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
  ami                    = "ami-0cd6445ee5fdfd2a3"
  instance_type          = "c7i-flex.large"
  subnet_id              = "subnet-05321b19c9d5946ea"
  vpc_security_group_ids = ["sg-09d236d4e61ec5a23"]
  key_name               = "ohio123"

  tags = {
    Name = "terraform-nginx-node"
  }
}

resource "aws_instance" "java-node" {
  ami                    = "ami-049e56b648d3fe48e"
  instance_type          = "c7i-flex.large"
  subnet_id              = "subnet-05321b19c9d5946ea"
  vpc_security_group_ids = ["sg-09d236d4e61ec5a23"]
  key_name               = "ohio123"

  tags = {
    Name = "terraform-java-node"
  }
}


resource "aws_instance" "python-node" {
  ami                    = "ami-0165eb15ed3c69fef"
  instance_type          = "c7i-flex.large"
  subnet_id              = "subnet-05321b19c9d5946ea"
  vpc_security_group_ids = ["sg-09d236d4e61ec5a23"]
  key_name               = "ohio123"

  tags = {
    Name = "terraform-python-node"
  }
}
