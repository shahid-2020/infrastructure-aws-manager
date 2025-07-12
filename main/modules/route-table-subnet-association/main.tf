resource "aws_route_table_association" "this" {
  count = length(var.subnet_ids)

  route_table_id = var.route_table_id
  subnet_id      = var.subnet_ids[count.index]
}