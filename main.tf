provider "aws" {
  region = "eu-north-1"
}

# Web Server 1 Instance
resource "aws_instance" "one" {
  ami               = "ami-0f65a9eac3c203b54"
  instance_type     = "t2.micro"
  key_name          = "devopsbysarvesh"
  vpc_security_group_ids = [aws_security_group.five.id]
  availability_zone = "eu-north-1a"
  
  user_data = <<-EOF
    #!/bin/bash
    yum install httpd -y
    systemctl start httpd
    chkconfig httpd on
    echo "hai all this is my app created by terraform infrastructure by raham sir server-1" > /var/www/html/index.html
  EOF
  
  tags = {
    Name = "web-server-1"
  }
}

# Web Server 2 Instance
resource "aws_instance" "two" {
  ami               = "ami-0f65a9eac3c203b54"
  instance_type     = "t2.micro"
  key_name          = "devopsbysarvesh"
  vpc_security_group_ids = [aws_security_group.five.id]
  availability_zone = "eu-north-1b"
  
  user_data = <<-EOF
    #!/bin/bash
    yum install httpd -y
    systemctl start httpd
    chkconfig httpd on
    echo "hai all this is my website created by terraform infrastructure by raham sir server-2" > /var/www/html/index.html
  EOF

  tags = {
    Name = "web-server-2"
  }
}

# App Server 1 Instance
resource "aws_instance" "three" {
  ami               = "ami-0f65a9eac3c203b54"
  instance_type     = "t2.micro"
  key_name          = "devopsbysarvesh"
  vpc_security_group_ids = [aws_security_group.five.id]
  availability_zone = "eu-north-1a"
  
  tags = {
    Name = "app-server-1"
  }
}

# App Server 2 Instance
resource "aws_instance" "four" {
  ami               = "ami-0f65a9eac3c203b54"
  instance_type     = "t2.micro"
  key_name          = "devopsbysarvesh"
  vpc_security_group_ids = [aws_security_group.five.id]
  availability_zone = "eu-north-1b"
  
  tags = {
    Name = "app-server-2"
  }
}

# Security Group for ELB
resource "aws_security_group" "five" {
  name = "elb-sg"
  
  ingress {
    from_port   = 22
    to_port     = 22
    protocol    = "tcp"
    cidr_blocks = ["0.0.0.0/0"]
  }

  ingress {
    from_port   = 80
    to_port     = 80
    protocol    = "tcp"
    cidr_blocks = ["0.0.0.0/0"]
  }

  egress {
    from_port   = 0
    to_port     = 0
    protocol    = "-1"
    cidr_blocks = ["0.0.0.0/0"]
  }
}

# S3 Bucket
resource "aws_s3_bucket" "six" {
  bucket = "devopsbysarvesh123456789987654321"
}

# IAM Users
resource "aws_iam_user" "seven" {
  for_each = var.user_names
  name     = each.value
}

# Input variable for IAM user names
variable "user_names" {
  description = "List of IAM users"
  type        = set(string)
  default     = ["user1", "user2", "user3", "user4"]
}

# EBS Volume
resource "aws_ebs_volume" "eight" {
  availability_zone = "eu-north-1a"
  size              = 40
  
  tags = {
    Name = "ebs-001"
  }
}
