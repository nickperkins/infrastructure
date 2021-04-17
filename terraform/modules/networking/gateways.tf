resource "aws_internet_gateway" "main" {
  vpc_id = aws_vpc.main.id

  tags = merge(var.default_tags,
    {
      Name = "${var.name}-${var.environment}"
    }
  )
}

resource "aws_eip" "nat" {
  count = length(aws_subnet.public.*)
  vpc   = true

  tags = merge(var.default_tags,
    {
      Name = "${var.name}-${var.environment}-${local.az_charaters[count.index]}"
    }
  )

  depends_on = [
    aws_internet_gateway.main
  ]
}

resource "aws_nat_gateway" "main" {
  count = length(aws_subnet.public.*)

  allocation_id = aws_eip.nat[count.index].id
  subnet_id     = aws_subnet.public[count.index].id

  tags = merge(var.default_tags,
    {
      Name = "${var.name}-${var.environment}-${local.az_charaters[count.index]}"
    }
  )

  depends_on = [
    aws_internet_gateway.main
  ]
}
