variable "ecr_repositories" {
  description = "Map of ECR repositories"

  type = map(object({
    image_tag_mutability = string
    scan_on_push         = bool
  }))
}

variable "tags" {
  description = "Common Tags"

  type    = map(string)
  default = {}
}
