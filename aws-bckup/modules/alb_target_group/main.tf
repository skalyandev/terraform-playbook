resource "aws_lb_target_group" "nginx" {

  name        = "${var.environment}-nginx-tg"
  port        = 80
  protocol    = "HTTP"
  target_type = "instance"
  vpc_id      = var.vpc_id

  health_check {
    path                = "/"
    port                = "traffic-port"
    protocol            = "HTTP"
    healthy_threshold   = 2
    unhealthy_threshold = 2
    interval            = 30
  }

  tags = merge(
    var.tags,
    {
      Name = "${var.environment}-nginx-tg"
    }
  )
}

resource "aws_lb_target_group_attachment" "bastion" {

  target_group_arn = aws_lb_target_group.nginx.arn

  target_id = var.bastion_instance_id

  port = 80
}
