resource "aws_subnet" "public" {
  count = length(local.az_charaters)
  vpc_id = aws_vpc.main.id
  cidr_block = cidrsubnet(var.cidr_block, var.subnet_newbits, count.index + 1)
  map_public_ip_on_launch = true
  

  tags = merge(var.common_tags, {
    Name = "${local.environment}-Public-${local.az_charaters[count.index]}"
    Tier = "Public"
  })
}

resource "aws_subnet" "private" {
  count = length(data.aws_availability_zones.available.names)
  vpc_id = aws_vpc.main.id
  cidr_block = cidrsubnet(var.cidr_block, var.subnet_newbits, length(local.az_charaters) + count.index + 1)

  tags = merge(var.common_tags, {
    Name = "${local.environment}-Private-${local.az_charaters[count.index]}"
    Tier = "Private"
  })
}
