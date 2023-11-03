terraform {
  required_providers {
    aws = {
      source = "hashicorp/aws"
    }
  }
}

provider "aws" {
  region = var.region_name
}

variable "region_name" {
  type    = string
  default = "us-east-1"
}

variable "keypair_name" {
  type    = string
  default = "demo-key"
}

data "aws_key_pair" "this" {
  key_name = var.keypair_name
}
