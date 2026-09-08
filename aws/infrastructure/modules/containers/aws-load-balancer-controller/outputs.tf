#########################################################
# HELM RELEASE OUTPUT
#########################################################

output "helm_release_name" {

  value = helm_release.aws_load_balancer_controller.name

}


output "namespace" {

  value = helm_release.aws_load_balancer_controller.namespace

}
