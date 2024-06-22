resource "aws_lb" "terraform_lb" {
  name               = "terraform-lb"
  internal           = false
  load_balancer_type = "application"
  security_groups    = [aws_security_group.Security_group_terraform.id]
  subnets            = [aws_subnet.public_subnet_1.id, aws_subnet.public_subnet_2.id]
}

resource "aws_lb_listener" "example_listener" {
  load_balancer_arn = aws_lb.terraform_lb.arn
  port              = 80
  protocol          = "HTTP"

  default_action {
    type             = "forward"
    target_group_arn = aws_lb_target_group.terraform_target_group.arn
  }
}

resource "aws_lb_target_group" "terraform_target_group" {
  name     = "terraform-target-group"
  port     = 80
  protocol = "HTTP"
  vpc_id   = aws_vpc.TerraformVPC.id

  health_check {
    path                = "/"
    interval            = 30
    timeout             = 10
    healthy_threshold   = 2
    unhealthy_threshold = 2
  }

  depends_on = [aws_instance.public_instance_1, aws_instance.public_instance_2]
}

resource "aws_lb_target_group_attachment" "terraform_attachment_1" {
  target_group_arn = aws_lb_target_group.terraform_target_group.arn
  target_id        = aws_instance.public_instance_1.id
}

resource "aws_lb_target_group_attachment" "terraform_attachment_2" {
  target_group_arn = aws_lb_target_group.terraform_target_group.arn
  target_id        = aws_instance.public_instance_2.id
}
