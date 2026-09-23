resource "aws_route_table_association" "public" {

  count = length(var.public_subnet_ids)

  subnet_id = var.public_subnet_ids[count.index]

  route_table_id = var.route_table_id

}


resource "aws_route_table_association" "private" {

  count = length(var.private_subnet_ids)

  subnet_id = var.private_subnet_ids[count.index]

  route_table_id = var.route_table_id


}
