module "terraform_state_bucket" {

  source = "./modules/storage"

  bucket_name   = var.bucket_name
  force_destroy = var.force_destroy

  tags = merge(
    local.common_tags,
    var.tags
  )

}
