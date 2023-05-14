// Security Group for EC2 Instance
resource "aws_security_group" "designflow-ec2-sg" {
  name = "designflow-ec2-sg"
  description = "Allow HTTP traffic on EC2 instance"

  ingress {
    from_port   = 3000
    to_port     = 3000
    protocol    = "tcp"
    cidr_blocks = ["0.0.0.0/0"]
  }

  egress {
    from_port   = 0
    to_port     = 0
    protocol    = "tcp"
    cidr_blocks = ["0.0.0.0/0"]
  }
}

// Security Group for RDS Instance
resource "aws_security_group" "designflow-rds-sg" {
  name = "designflow-rds-sg"
  description = "Allow traffic on RDS instance"

  ingress {
    from_port   = 3306
    to_port     = 3306
    protocol    = "tcp"
    security_groups = [aws_security_group.designflow-ec2-sg.id]
  }

  egress {
    from_port   = 0
    to_port     = 0
    protocol    = "tcp"
    cidr_blocks = ["0.0.0.0/0"]
  }
}