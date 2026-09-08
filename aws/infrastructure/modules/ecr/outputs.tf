output "repository_urls" {

  value = {
    for repo, value in aws_ecr_repository.this :
    repo => value.repository_url
  }
}

output "repository_arns" {

  value = {
    for repo, value in aws_ecr_repository.this :
    repo => value.arn
  }
}

output "repository_names" {

  value = {
    for repo, value in aws_ecr_repository.this :
    repo => value.name
  }
}
