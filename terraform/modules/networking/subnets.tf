resource "aws_subnet" "public" {
  count                   = length(local.az_charaters)
  vpc_id                  = aws_vpc.main.id
  cidr_block              = cidrsubnet(var.vpc_base_cidr, var.subnet_newbits, count.index + 1)
  map_public_ip_on_launch = true


  tags = merge(var.default_tags, {
    Name = "${var.name}-${var.environment}-public-${local.az_charaters[count.index]}"
    Tier = "public"
  })
}

resource "aws_subnet" "private" {
  count      = length(data.aws_availability_zones.available.names)
  vpc_id     = aws_vpc.main.id
  cidr_block = cidrsubnet(var.vpc_base_cidr, var.subnet_newbits, length(local.az_charaters) + count.index + 1)

  tags = merge(var.default_tags, {
    Name = "${var.name}-${var.environment}-private-${local.az_charaters[count.index]}"
    Tier = "private"
  })
}
