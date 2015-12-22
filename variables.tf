variable "access_key" {}
variable "secret_key" {}
variable "mgt_subnets" {}

resource "aws_key_pair" "deployer" {
  key_name = "deploy-key"
  public_key = "${file(\"deploy-key.pub\")}"
}

variable "region"     {
  description = "AWS region to host your network"
  default     = "eu-central-1"
}

variable "vpc_cidr" {
    description = "CIDR for the VPC"
    default = "10.0.0.0/16"
}

variable "public_subnet_cidr" {
  description = "CIDR for public subnet"
  default     = "10.0.0.0/24"
}

variable "amis" {
    description = "Ubuntu 14.04.03 AMI as starting point"
    default = {
      eu-central-1 = "ami-02392b6e"
  }
}

variable "app-ami" {
    description = "Dev app ami"
    default = "ami-6c989571"
}
