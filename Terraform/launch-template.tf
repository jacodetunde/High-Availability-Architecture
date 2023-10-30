resource "aws_launch_template" "Web" {
  name          = "web-launch-template"
  instance_type = "t2.micro" # Change to your desired instance type

  block_device_mappings {
    device_name = "/dev/xvda"

    ebs {
      volume_size = 20 # Change to your desired volume size
      volume_type = "gp2"
    }
  }

  network_interfaces {
    associate_public_ip_address = true # Set to true for a public IP
  }

  iam_instance_profile {
    name = aws_iam_role.ec2_read_only.name # Replace with your IAM instance profile name
  }
  # user_data = file("web-automation.sh")
  image_id = var.ami # Replace with your desired AMI ID

  tags = {
    Name = "web-launch-template"
  }
}

resource "aws_launch_template" "App" {
  name          = "app-launch-template"
  instance_type = "t2.micro" # Change to your desired instance type

  block_device_mappings {
    device_name = "/dev/xvda"

    ebs {
      volume_size = 20 # Change to your desired volume size
      volume_type = "gp2"
    }
  }

  network_interfaces {
    associate_public_ip_address = false # Set to true for a public IP
  }

  iam_instance_profile {
    name = aws_iam_role.ec2_read_only.name # Replace with your IAM instance profile name
  }

  # user_data = file("app-automation.sh")
  image_id = var.ami# Replace with your desired AMI ID

  tags = {
    Name = "app-launch-template"
  }
}
