// launch aws rds mysql instance
resource "aws_db_instance" "designflow_rds_instance" {
  allocated_storage      = 20
  storage_type           = "gp2"
  engine                 = "mysql"
  engine_version         = "8.0.32"
  instance_class         = var.db_instance_type
  identifier             = "designflow-mysql"
  db_name                = var.db_name
  username               = var.db_username
  password               = var.db_password
  vpc_security_group_ids = [aws_security_group.designflow-rds-sg.id]
  port                   = 3306
  publicly_accessible    = true
  skip_final_snapshot    = true
  tags = {
    Name = "designflow-mysql-server"
  }
}


// launch aws ec2 instance
resource "aws_instance" "designflow_ec2_instance" {
  count                  = var.instance_count
  ami                    = var.instance_ami
  instance_type          = var.instance_type
  vpc_security_group_ids = [aws_security_group.designflow-ec2-sg.id]

  tags = {
    Name = var.instance_name
  }
}

