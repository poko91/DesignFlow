variable "aws_region" {
  default = "ap-northeast-1"
}

variable "access_key" {
  default = ""
}

variable "secret_key" {
  default = ""
}

// variables for ec2 instance

variable "instance_ami" {
  default = "ami-0d979355d03fa2522"
}

variable "instance_type" {
  default = "t2.micro"
}

variable "instance_name" {
  default = "my-ec2-instance"
}

variable "instance_count" {
  default = 1
}


// variables for rds instance

variable "db_instance_name" {
  default = "mydbinstance"
}

variable "db_name" {
  default = "designflow"
}

variable "db_username" {
  default = "myuser"
}

variable "db_password" {
  default = "mypassword"
}

variable "db_instance_type" {
  default = "db.t4g.micro"
}