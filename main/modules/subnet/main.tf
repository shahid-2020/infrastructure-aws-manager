resource "aws_subnet" "this" {
  count = length(var.cidr_blocks)

  vpc_id                  = var.vpc_id
  cidr_block              = var.cidr_blocks[count.index]
  availability_zone       = element(var.availability_zones, count.index)
  map_public_ip_on_launch = var.auto_assign_public_ip

  tags = merge(var.tags, {
    Name = "${var.name_prefix}${var.name_prefix != "" ? "-" : ""}${var.auto_assign_public_ip ? "public" : "private"}-subnet-${count.index + 1}"
  })
}