output "security_group_rule_ids" {

  description = "Security Group Rule IDs"

  value = merge(
    try({
      for k, v in aws_security_group_rule.cidr :
      k => v.id
    }, {}),
    try({
      for k, v in aws_security_group_rule.sg :
      k => v.id
    }, {}),
    try({
      for k, v in aws_security_group_rule.ipv6 :
      k => v.id
    }, {}),
    try({
      for k, v in aws_security_group_rule.self :
      k => v.id
    }, {}),
    try({
      for k, v in aws_security_group_rule.prefix_list :
      k => v.id
    }, {})

  )

}
