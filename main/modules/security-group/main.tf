resource "aws_security_group" "this" {
  name   = "${var.name}-sg"
  vpc_id = var.vpc_id

  tags = merge(var.tags, { Name : "${var.name}-sg" })
}