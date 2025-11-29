locals {
  # Validate that CIDR blocks and availability zones match in count
  subnet_count = length(var.cidr_blocks)
  az_count     = length(var.availability_zones)

  # This will cause a clear error if counts don't match
  validate_counts = local.subnet_count != local.az_count ? tobool("ERROR: Number of CIDR blocks (${local.subnet_count}) must match number of availability zones (${local.az_count}).") : true
}

resource "aws_subnet" "this" {
  count = local.subnet_count

  vpc_id                  = var.vpc_id
  cidr_block              = var.cidr_blocks[count.index]
  availability_zone       = var.availability_zones[count.index]
  map_public_ip_on_launch = var.auto_assign_public_ip

  tags = merge(var.tags, {
    Name = "${var.name_prefix}${var.name_prefix != "" ? "-" : ""}${var.auto_assign_public_ip ? "public" : "private"}-subnet-${count.index + 1}"
  })
}