variable "name" {
  type        = string
  description = "The name for the network"
}

variable "environment" {
  type        = string
  description = "The environment name"
}

variable "cidr_block" {
  type = string
}

variable "subnet_newbits" {
  type    = number
  default = 4
}

variable "common_tags" {
  type    = map(string)
  default = {}
}
