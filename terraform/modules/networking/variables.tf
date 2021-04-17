variable "environment" {
  type = string
  description = "The environment name"
}

variable "region" {
  type = string
  description = "AWS region to use"
  default = "ap-southeast-2"
}

variable "vpc_base_cidr" {
  type = string
  description = "Base CIDR Block for VPC"
  default = "10.0.0.0/16"
}

variable "common_tags" {
  type = map(string)
  description = "Common Tags for the module"
}