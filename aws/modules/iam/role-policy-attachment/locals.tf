locals {

  ##########################################################
  # CUSTOM POLICIES
  ##########################################################

  custom_policy_map = merge([

    for attachment_name, attachment in var.attachments : {

      for policy in attachment.custom_policies :

      "${attachment_name}-${policy}" => {
        role = attachment.role
        policy_arn = var.policy_arns[policy]
      }

    }

  ]...)

  ##########################################################
  # AWS MANAGED POLICIES
  ##########################################################

  managed_policy_map = merge([

    for attachment_name, attachment in var.attachments : {

      for policy in attachment.managed_policies :

      "${attachment_name}-${replace(policy, ":", "-")}" => {
        role = attachment.role
        policy_arn = policy

      }

    }

  ]...)

}
