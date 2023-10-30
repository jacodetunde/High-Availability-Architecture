resource "aws_db_subnet_group" "default" {
  name       = "ventura-db-subnet-group"
  subnet_ids = [aws_subnet.rds1.id, aws_subnet.rds2.id] # Fixed the subnet IDs

  tags = {
    Name = "ventura-db-subnet-group"
  }
}

resource "aws_db_instance" "default" {
  allocated_storage    = var.allocated_storage
  db_name              = var.db_name
  engine               = var.engine
  engine_version       = var.engine_version
  instance_class       = var.instance_class
  username             = var.username
  password             = var.password
  parameter_group_name = var.parameter_group_name
  skip_final_snapshot  = local.skip_final_snapshot

  db_subnet_group_name = aws_db_subnet_group.default.name

  tags = merge(local.common_tags, {Name = "${var.name}-rds-instance"})
}
