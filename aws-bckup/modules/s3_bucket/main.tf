resource "aws_s3_bucket_policy" "restrict_to_bastion" {

  bucket = aws_s3_bucket.this.id

  policy = jsonencode({

    Version = "2012-10-17"

    Statement = [

      {
        Sid    = "AllowBastionOnly"
        Effect = "Allow"

        Principal = {
          AWS = var.bastion_role_arn
        }

        Action = [
          "s3:GetObject",
          "s3:PutObject",
          "s3:DeleteObject",
          "s3:DeleteObjectVersion",
          "s3:ListBucket"
        ]

        Resource = [
          aws_s3_bucket.this.arn,
          "${aws_s3_bucket.this.arn}/*"
        ]
      }
    ]
  })
}


resource "aws_s3_bucket" "this" {
  
  bucket = var.bucket_name
  tags   = {
    Name = var.bucket_name
  }
}


resource "aws_s3_bucket_versioning" "this" {
  bucket = aws_s3_bucket.this.id
  
  versioning_configuration {
    status  = "Enabled"
  }

}

resource "aws_s3_bucket_server_side_encryption_configuration" "bucket_versioning" {

   bucket = aws_s3_bucket.this.id

   rule {
     apply_server_side_encryption_by_default {
       sse_algorithm = "AES256"  
     }
   }
}




