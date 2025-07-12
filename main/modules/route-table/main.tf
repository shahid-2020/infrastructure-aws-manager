resource "aws_route_table" "this" {
  vpc_id = var.vpc_id

  route {
    cidr_block = var.vpc_cidr_block
    gateway_id = "local"
  }

  dynamic "route" {
    for_each = var.additional_routes

    content {
      cidr_block     = route.value.cidr_block
      gateway_id     = lookup(route.value, "gateway_id", null)
      nat_gateway_id = lookup(route.value, "nat_gateway_id", null)
    }
  }

  tags = var.tags
}