resource "aws_eip" "this" {
  domain = "vpc"

  tags = merge(var.tags, { Name = "${var.tags["Name"]}-eip" })
}

resource "aws_nat_gateway" "this" {
  allocation_id = aws_eip.this.id
  subnet_id     = var.subnet_id

  tags = var.tags
}
