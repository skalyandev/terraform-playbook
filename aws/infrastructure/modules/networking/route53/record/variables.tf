variable "zone_id" {
  description = "Route53 Hosted Zone ID."
  type        = string
}

variable "records" {
  description = "Route53 Alias records."

  type = map(object({
    name        = string
    alb_dns_name = string
    alb_zone_id  = string
  }))
}

variable "evaluate_target_health" {
  description = "Whether Route53 evaluates target health."
  type        = bool
  default     = true
}
