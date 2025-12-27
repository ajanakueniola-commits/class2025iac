variable "region" {
  default = "us-east-2"
}

variable "instance_type" {
  default = "c7i-flex.large"
}

variable "key_name" {
  description = "SSH key pair name"
}

variable "vpc_id" {}

variable "subnet_id" {}

variable "allowed_ssh_cidr" {
  default = ["10.0.0.0/16"]
}

variable "fastapi_port" {
  default = 8000
}
