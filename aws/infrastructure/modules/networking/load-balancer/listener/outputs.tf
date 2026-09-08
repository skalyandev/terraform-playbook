#########################################################
# LISTENER IDS
#########################################################

output "listener_ids" {

  value = {

    for k, v in aws_lb_listener.this :

    k => v.id

  }

}

#########################################################
# LISTENER ARNS
#########################################################

output "listener_arns" {

  value = {

    for k, v in aws_lb_listener.this :

    k => v.arn

  }

}
