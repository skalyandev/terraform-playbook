resource "aws_eip" "this" {

  for_each = var.elastic_ips

  domain = "vpc"

  tags = merge(
    var.tags,
    {
      Name = each.value.name
    }
  )
}
