variable "cidr_block" {
  type = string
}

variable "subnet_newbits" {
  type = number
  default = 4
}

variable "common_tags" {
  type    = map(string)
  default = {}
}
