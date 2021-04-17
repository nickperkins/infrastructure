resource "aws_vpc" "main" {
  cidr_block = var.vpc_base_cidr

  tags = merge(var.default_tags,
    {
      Name = "${var.name}-${var.environment}"
    }
  )
}
