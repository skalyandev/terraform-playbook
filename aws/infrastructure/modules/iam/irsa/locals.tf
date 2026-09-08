#########################################################
# REMOVE HTTPS FROM OIDC URL
#########################################################

locals {

  oidc_url = replace(

    var.oidc_provider_url,
    "https://",
    ""

  )

}

#########################################################
# POLICY ATTACHMENTS
#########################################################

locals {

  custom_policy_map = {

    for item in flatten([

      for role_name, role in var.irsa_roles : [
        for policy in role.custom_policies : {
          key = "${role_name}-${policy}"
          role = role_name
          policy_arn = var.policy_arns[policy]
        }

      ]

    ]) :

    item.key => item

  }

}
