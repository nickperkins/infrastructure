resource "aws_route_table" "external" {
  vpc_id = aws_vpc.main.id

  tags = merge(var.common_tags,
    {
      Name = "main"
    }
  )
}

resource "aws_route_table" "internal" {
  vpc_id = aws_vpc.main.id

  tags = merge(var.common_tags,
    {
      Name = "main"
    }
  )
}

resource "aws_route" "public_internet_gateway" {
  route_table_id         = aws_route_table.external.id
  destination_cidr_block = "0.0.0.0/0"
  gateway_id             = aws_internet_gateway.main.id

  timeouts {
    create = "5m"
  }
}

resource "aws_route_table_association" "external_public" {
  count = length(aws_subnet.public.*)

  subnet_id      = element(aws_subnet.public.*.id, count.index)
  route_table_id = aws_route_table.external.id
}

resource "aws_route_table_association" "internal_private" {
  count = length(aws_subnet.private.*)

  subnet_id      = element(aws_subnet.private.*.id, count.index)
  route_table_id = aws_route_table.internal.id
}
