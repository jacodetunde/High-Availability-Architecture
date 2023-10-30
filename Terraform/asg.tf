# resource "aws_autoscaling_group" "web" {
#   desired_capacity          = 2
#   max_size                  = 5
#   min_size                  = 1
#   launch_template {
#     id      = aws_launch_template.Web.id
#     version = "$Latest"
#   }

#   vpc_zone_identifier       = aws_subnet.private1.*.id # Use the appropriate list of subnet IDs

#   health_check_type         = "EC2"
#   force_delete              = true
#   wait_for_capacity_timeout = "0"

#   tag {
#     key                      = "Name"
#     value                    = "web-instance"
#     propagate_at_launch      = true
#   }
# }

# resource "aws_autoscaling_group" "app" {
#   desired_capacity          = 2
#   max_size                  = 5
#   min_size                  = 1
#   launch_template {
#     id      = aws_launch_template.App.id
#     version = "$Latest"
#   }

#   vpc_zone_identifier       = aws_subnet.private2.*.id # Use the appropriate list of subnet IDs

#   health_check_type         = "EC2"
#   force_delete              = true
#   wait_for_capacity_timeout = "0"

#   tag {
#     key                      = "Name"
#     value                    = "app-instance"
#     propagate_at_launch      = true
#   }
# }
