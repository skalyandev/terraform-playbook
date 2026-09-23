resource "aws_lb" "this" {
  
  name = "${var.environment}-alb"

  internal = false

  load_balancer_type = "application"

  security_groups = [
    var.alb_sg_id
  ]

  subnets = var.public_subnets

  tags = merge(
    var.tags,
    {
      Name = "${var.environment}"
    }
  )

}

resource "aws_lb_listener" "http" {

  load_balancer_arn = aws_lb.this.arn

  port = 80

  protocol = "HTTP"

  default_action {

    type = "forward"

    target_group_arn = var.target_group_arn
  }

  tags = merge(
    var.tags,
    {
      Name = "${var.environment}"
    }
  )

}
