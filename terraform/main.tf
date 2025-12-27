terraform {
  backend "s3" {
    bucket  = "funmi-cicd-state-bucket"
    key     = "envs/dev/terraform.tfstate"
    region  = "us-east-2"
    encrypt = true

  }
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

# -------------------------
# Web Node Security Group
# -------------------------

resource "aws_security_group" "web_sg" {

 name        = "${var.project_name}-web-sg"
  description = "Security group for web server allowing SSH and HTTP"
  vpc_id      = aws_vpc.main.id


  # inbound SSH

  ingress {
    description = "SSH"
    from_port   = 22
    to_port     = 22
    protocol    = "tcp"
    cidr_blocks = ["0.0.0.0/0"]
  }

  # inbound 80 (web)
  ingress {
    description = "Web port 80"
    from_port   = 80
    to_port     = 80
    protocol    = "tcp"
    cidr_blocks = ["0.0.0.0/0"]
  }

# Inbound HTTPS 443 (web)
  ingress {
    description = "HTTPS from anywhere"
    from_port   = 443
    to_port     = 443
    protocol    = "tcp"
    cidr_blocks = ["0.0.0.0/0"]
  }
  # Allow all outbound traffic
  egress {
    from_port   = 0
    to_port     = 0
    protocol    = "-1"
    cidr_blocks = ["0.0.0.0/0"]
  }

  tags = {
    Name = "${var.project_name}-web-security_group"
    Environment = var.environment
  }

}
# Data source to get latest Amazon_Linux AMI
data "aws_ami" "amazon_linux" {
  most_recent = true
  owners      = ["076806502192"]

  filter {
    name   = "name"
    values = ["al2023-ami-*-x86_64"]
  }

  filter {
    name   = "virtualization-type"
    values = ["hvm"]
  }
}

#-------------------------
# Web EC2 Instance
# ------------------------


resource "aws_instance" "web-node" {
  ami                    = data.aws_ami.amazon_linux.id
  instance_type          = var.instance_type
  subnet_id              = aws_subnet.public.id
  vpc_security_group_ids = [aws_security_group.web_sg.id]
  key_name               = var.key_name

  tags = {
    Name = "terraform-web-node"
  }
}

# -------------------------
# Java Node Security Group
# -------------------------

resource "aws_security_group" "java_sg" {

   name        = "${var.project_name}-java-sg"
  description = "Security group for web server allowing SSH and HTTP"
  vpc_id      = aws_vpc.main.id

  # inbound SSH

  ingress {
    description = "SSH"
    from_port   = 22
    to_port     = 22
    protocol    = "tcp"
    cidr_blocks = ["0.0.0.0/0"]
  }

  # inbound 9090 (java)
  ingress {
    description = "java app port 9090"
    from_port   = 9090
    to_port     = 9090
    protocol    = "tcp"
    cidr_blocks = ["0.0.0.0/0"]
  }

  # Allow all outbound traffic
  egress {
    from_port   = 0
    to_port     = 0
    protocol    = "-1"
    cidr_blocks = ["0.0.0.0/0"]
  }

  tags = {
     Name = "${var.project_name}-java-security_group"
    Environment = var.environment
  }

}

#-------------------------
# java EC2 Instance
# ------------------------

resource "aws_instance" "java-node" {
   ami                    = data.aws_ami.amazon_linux.id
  instance_type          = var.instance_type
  subnet_id              = aws_subnet.public.id
  vpc_security_group_ids = [aws_security_group.java_sg.id]
  key_name               = var.key_name

  tags = {
    Name = "terraform-java-node"
  }
}
# -------------------------
# Python Node Security Group
# -------------------------

resource "aws_security_group" "python_sg" {

  name        = "${var.project_name}-python-sg"
  description = "Security group for web server allowing SSH and HTTP"
  vpc_id      = aws_vpc.main.id


  # inbound SSH

  ingress {
    description = "SSH"
    from_port   = 22
    to_port     = 22
    protocol    = "tcp"
    cidr_blocks = ["0.0.0.0/0"]
  }

  # inbound 8000 (python)
  ingress {
    description = "Python app port 8000"
    from_port   = 8000
    to_port     = 8000
    protocol    = "tcp"
    cidr_blocks = ["0.0.0.0/0"]
  }

  # Allow all outbound traffic
  egress {
    from_port   = 0
    to_port     = 0
    protocol    = "-1"
    cidr_blocks = ["0.0.0.0/0"]
  }

  tags = {
     Name = "${var.project_name}-python-security_group"
    Environment = var.environment
  }

}

#-------------------------
# Python EC2 Instance
# ------------------------

resource "aws_instance" "python-node" {
  ami                    = data.aws_ami.amazon_linux.id
  instance_type          = var.instance_type
  subnet_id              = aws_subnet.public.id
  vpc_security_group_ids = [aws_security_group.python_sg.id]
  key_name               = var.key_name

  tags = {
    Name = "terraform-python-node"
  }
}

#--------------------------------
# Outputs - Public (external) IPs
#--------------------------------


output "web_node_ip" {
  description = " Public IP"
  value  = aws_instance.web-node.public_ip
}

output "python_node_ip" {
  description = " Public IP"
  value  = aws_instance.python-node.public_ip
}

output "java_node_ip" {
  description = " Public IP"
  value  = aws_instance.java-node.public_ip
}


