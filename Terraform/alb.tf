resource "aws_lb" "elb" {
  name               = "web-application-lb-tf"
  internal           = false
  load_balancer_type = "application"
  security_groups    = [aws_security_group.ELB.id]
  subnets            = [
    aws_subnet.public1.id,
    aws_subnet.public2.id
  ]

  tags = {
    Environment = "webLB"
  }
}

resource "aws_lb_target_group" "tg" {
  name        = "tg"
  port        = 80
  protocol    = "HTTP"
  target_type = "instance"
  vpc_id      = aws_vpc.main.id

  health_check {
    healthy_threshold   = 3
    unhealthy_threshold = 10
    timeout             = 5
    interval            = 10
    path                = "/"
    port                = 80
  }
}

resource "aws_lb_listener" "http" {
  load_balancer_arn = aws_lb.elb.arn
  port              = 80
  protocol          = "HTTP"

  default_action {
    type             = "forward"
    target_group_arn = aws_lb_target_group.tg.arn
  }
}

resource "aws_lb_target_group" "tg1" {
  name        = "tg1"
  port        = 80
  protocol    = "HTTP"
  target_type = "instance"
  vpc_id      = aws_vpc.main.id

  health_check {
    healthy_threshold   = 3
    unhealthy_threshold = 10
    timeout             = 5
    interval            = 10
    path                = "/"
    port                = 80
  }
}

# resource "aws_lb" "alb" {
#   name               = "app-application-lb-tf"
#   internal           = false
#   load_balancer_type = "application"
#   security_groups    = [aws_security_group.ALB.id]
#   subnets            = [
#     aws_subnet.public1.id,
#     aws_subnet.public2.id
#   ]

#   tags = {
#     Environment = "appLB"
#   }
# }

# resource "aws_lb_target_group" "tg2" {
#   name        = "tg2"
#   port        = 80
#   protocol    = "HTTP"
#   target_type = "instance"
#   vpc_id      = aws_vpc.main.id

#   health_check {
#     healthy_threshold   = 3
#     unhealthy_threshold = 10
#     timeout             = 5
#     interval            = 10
#     path                = "/"
#     port                = 80
#   }
# }

# resource "aws_lb_listener" "app" {
#   load_balancer_arn = aws_lb.elb.arn
#   port              = 80
#   protocol          = "HTTP"

#   default_action {
#     type             = "forward"
#     target_group_arn = aws_lb_target_group.tg2.arn
#   }
# }

# resource "aws_lb_target_group" "tg3" {
#   name        = "tg3"
#   port        = 80
#   protocol    = "HTTP"
#   target_type = "instance"
#   vpc_id      = aws_vpc.main.id

#   health_check {
#     healthy_threshold   = 3
#     unhealthy_threshold = 10
#     timeout             = 5
#     interval            = 10
#     path                = "/"
#     port                = 80
#   }
# }

