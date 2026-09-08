#########################################################
# S3 BUCKETS
#########################################################

resource "aws_s3_bucket" "this" {

  for_each = var.buckets

  bucket = coalesce(
    each.value.bucket_name,
    each.key
  )

  force_destroy = each.value.force_destroy

  tags = merge(
    var.tags,
    each.value.tags,
    {
      Name = coalesce(
        each.value.bucket_name,
        each.key
      )
    }
  )

}

#########################################################
# S3 BUCKET POLICIES
#########################################################

resource "aws_s3_bucket_policy" "this" {
  for_each = var.bucket_policies

  bucket = aws_s3_bucket.this[each.key].id
  policy = each.value
}



#########################################################
# S3 VERSIONING
#########################################################

resource "aws_s3_bucket_versioning" "this" {

  for_each = var.buckets

  bucket = aws_s3_bucket.this[each.key].id

  versioning_configuration {

    status = each.value.versioning_enabled ? "Enabled" : "Suspended"

  }

}


#########################################################
# S3 SERVER-SIDE ENCRYPTION
#########################################################

resource "aws_s3_bucket_server_side_encryption_configuration" "this" {

  for_each = {
    for k, v in var.buckets :
    k => v
    if v.encryption_enabled
  }

  bucket = aws_s3_bucket.this[each.key].id

  rule {

    apply_server_side_encryption_by_default {

      sse_algorithm = "AES256"

    }

  }

}


#########################################################
# S3 OBJECT OWNERSHIP
#########################################################

resource "aws_s3_bucket_ownership_controls" "this" {

  for_each = var.buckets

  bucket = aws_s3_bucket.this[each.key].id

  rule {

    object_ownership = each.value.object_ownership

  }

}


#########################################################
# S3 PUBLIC ACCESS BLOCK
#########################################################

resource "aws_s3_bucket_public_access_block" "this" {

  for_each = var.buckets

  bucket = aws_s3_bucket.this[each.key].id
  block_public_acls = each.value.block_public_acls
  block_public_policy = each.value.block_public_policy
  ignore_public_acls = each.value.ignore_public_acls
  restrict_public_buckets = each.value.restrict_public_buckets

}
