resource "aws_route_table" "public" {

  vpc_id = var.vpc_id
  
  route {
    cidr_block = "0.0.0.0/0"
    gateway_id = var.internet_gateway_id 
  }

  tags = merge(
    var.tags,
    {
      Name = "${var.name}-public-rt"
    }
  )
}


resource "aws_route_table" "private" {

  count = var.enable_nat_gateway ? 1 : 0

  vpc_id = var.vpc_id

  route {

    cidr_block = "0.0.0.0/0"

    nat_gateway_id = var.nat_gateway_id
  }

  tags = merge(
    var.tags,
    {
      Name = "${var.name}-private-rt"
    }
  )
}
