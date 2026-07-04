locals {

  #############################################################
  # Flatten all ingress and egress rules into a single list
  #############################################################

  rules = flatten([

    for sg_name, sg in var.security_group_rules : [

      for rule_type in ["ingress", "egress"] : [

        for rule_name, rule in lookup(sg, rule_type, {}) : {

          key = "${sg_name}-${rule_type}-${rule_name}"
          security_group = sg_name
          type = rule_type
          description = lookup(rule, "description", "")
          protocol = lookup(rule, "protocol", "-1")
          #######################################################
          # If port is supplied use it
          # Otherwise use from_port/to_port
          # If protocol == -1 then use 0/0
          #######################################################
          from_port = lookup(
            rule,
            "from_port",
            lookup(rule, "port",
              lookup(rule, "protocol", "-1") == "-1" ? 0 : 0
            )
          )
          to_port = lookup(
            rule,
            "to_port",
            lookup(rule, "port",
              lookup(rule, "protocol", "-1") == "-1" ? 0 : 0
            )
          )
          cidr_blocks = lookup(rule, "cidr_blocks", [])
          ipv6_cidr_blocks = lookup(rule, "ipv6_cidr_blocks", [])
          prefix_list_ids = lookup(rule, "prefix_list_ids", [])
          source_security_group = lookup(rule, "source_security_group", null)
          self = lookup(rule, "self", false)
        }

      ]

    ]

  ])

  #############################################################
  # Convert list to map for for_each
  #############################################################
  rules_map = {

    for rule in local.rules :
    rule.key => rule

  }
}
