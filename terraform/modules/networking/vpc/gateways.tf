resource "aws_internet_gateway" "main" {
  vpc_id = aws_vpc.main.id

  tags = merge(var.common_tags,
    {
      Name = "main"
    }
  )
}

resource "aws_eip" "nat_gateway" {
  count = length(aws_subnet.public.*)
  vpc   = true

  tags = merge(var.common_tags,
    {
      Name = "main-${local.az_charaters[count.index]}"
    }
  )

  depends_on = [
    aws_internet_gateway.main
  ]
}

resource "aws_nat_gateway" "main" {
  count = length(aws_subnet.public.*)

  allocation_id = element(aws_eip.nat_gateway.*.id, count.index)
  subnet_id     = element(aws_subnet.public.*.id, count.index)

  tags = merge(var.common_tags,
    {
      Name = "main-${local.az_charaters[count.index]}"
    }
  )

  depends_on = [
    aws_route_table_association.external_public
  ]
}
