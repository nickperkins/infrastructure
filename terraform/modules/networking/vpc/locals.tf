locals {
  custom_tags = {}
  az_charaters = [
    for name in data.aws_availability_zones.available.names :
    substr(name, -1, 1)
  ]
}
