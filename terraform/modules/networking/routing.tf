resource "aws_route_table" "public" {
  vpc_id = aws_vpc.main.id

  tags = merge(var.default_tags,
    {
      Name = "${var.name}-${var.environment}-public"
    }
  )
}

resource "aws_route_table" "private" {
  count = length(aws_subnet.private)

  vpc_id = aws_vpc.main.id

  tags = merge(var.default_tags,
    {
      Name = "${var.name}-${var.environment}-private-${local.az_charaters[count.index]}"
    }
  )
}

resource "aws_route" "public_internet_gateway" {
  route_table_id         = aws_route_table.public.id
  destination_cidr_block = "0.0.0.0/0"
  gateway_id             = aws_internet_gateway.main.id

  timeouts {
    create = "5m"
  }
}

resource "aws_route" "private_internet_gateway" {
  count = length(aws_subnet.private)

  route_table_id         = aws_route_table.private[count.index].id
  destination_cidr_block = "0.0.0.0/0"
  nat_gateway_id         = aws_nat_gateway.main[count.index].id

  depends_on = [aws_route_table.private]

}


resource "aws_route_table_association" "public" {
  count = length(aws_subnet.public.*)

  subnet_id      = aws_subnet.public[count.index].id
  route_table_id = aws_route_table.public.id
}

resource "aws_route_table_association" "private" {
  count = length(aws_subnet.private.*)

  subnet_id      = aws_subnet.private[count.index].id
  route_table_id = aws_route_table.private[count.index].id
}
