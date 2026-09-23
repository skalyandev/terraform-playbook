resource "aws_launch_template" "this" {

  name = var.name

  instance_type = var.instance_type

  block_device_mappings {

    device_name = "/dev/xvda"

    ebs {

      volume_size = var.volume_size

      volume_type = "gp3"
    }
  }

  metadata_options {

    http_endpoint = "enabled"

    http_tokens = "required"

    http_put_response_hop_limit = 1
  }

  vpc_security_group_ids = var.security_group_ids

  update_default_version = true

  tag_specifications {

    resource_type = "instance"

    tags = var.tags
  }
}
