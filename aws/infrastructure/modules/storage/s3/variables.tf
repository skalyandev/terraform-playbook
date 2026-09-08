#########################################################
# S3 BUCKETS
#########################################################

variable "buckets" {

  description = "S3 bucket configurations."

  type = map(object({

    #####################################################
    # BUCKET
    #####################################################

    bucket_name = optional(string)
    force_destroy = optional(bool, false)

    #####################################################
    # VERSIONING
    #####################################################

    versioning_enabled = optional(bool, true)

    #####################################################
    # ENCRYPTION
    #####################################################

    encryption_enabled = optional(bool, true)

    #####################################################
    # OBJECT OWNERSHIP
    #####################################################

    object_ownership = optional(
      string,
      "BucketOwnerEnforced"
    )

    #####################################################
    # PUBLIC ACCESS BLOCK
    #####################################################

    block_public_acls = optional(bool, true)
    block_public_policy = optional(bool, true)
    ignore_public_acls = optional(bool, true)
    restrict_public_buckets = optional(bool, true)

    #####################################################
    # TAGS
    #####################################################

    tags = optional(map(string), {})

  }))

}


variable "bucket_policies" {
  description = "Optional S3 bucket policies keyed by bucket key."
  type        = map(string)
  default     = {}
}

#########################################################
# COMMON TAGS
#########################################################

variable "tags" {

  description = "Common tags applied to all S3 buckets."
  type = map(string)
  default = {}

}
