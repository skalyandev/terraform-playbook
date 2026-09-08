resource "aws_route53_record" "this" {

  for_each = var.records

  zone_id = var.zone_id
  name    = each.value.name
  type    = "A"

  alias {

    name                   = each.value.alb_dns_name
    zone_id                = each.value.alb_zone_id
    evaluate_target_health = var.evaluate_target_health
  }
}
