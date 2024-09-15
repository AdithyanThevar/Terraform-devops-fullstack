provider "aws" {
  profile = "test-user"
  region  = "ap-south-1"
}

resource "aws_key_pair" "test-key" {
  key_name   = "test-key"
  public_key = "ssh-rsa AAAAB3NzaC1yc2EAAAADAQABAAABgQC/Rs8lt0nlsfRD3SaK14wuJtd9hcFUlU/5VXjNv+zCSOsKtfxd2LFIOfgBsFuMfUH6PJT65qurQCx3sIXlSQTkyB0nvoqMyykEo9rA9Oeg6Wr29oWuUSGEo508IQYG/yLbrTUN1O0lO2bSxzpZ6Ahv/Hd95VUlFbAUgBPmMa016q/3KSZcfwf4Hq4lSmo5gIHO/dpkuhRh9nYePK701IUJG0f3tQFfMOe7u1ZytzjPCJRnKnnL/h8JXPL9ooJYm973QsGrB5hg4A71hwc3EXw0EyNDix3elhwhKYTpPXP5L0DYbNK1xnk5RaKmsup7K3xX6mk5n6CaCoDjt+5z/MF52q+qumbimguuNwS0ryerh8jqLRz6OPFHnjiEw24wybmbkxWJ44awdIsd9n4M+PNU2KsFuraJS47D2PZCp/S27lvE/cVJswUrH1VryUzN5mvaxQcJrg5Jsbz2zC2HU+gNIs+cLRMidLc6DaWJPWaZu2Zsf+V5hSx6ushgNzID5Yk="
}

resource "aws_security_group" "test_sg" {
  description  = "Test security group"

  ingress {
    from_port   = 22
    to_port     = 22
    protocol    = "tcp"
    cidr_blocks = ["23.226.124.100/32"]  
  }

  ingress {
    from_port   = 22
    to_port     = 22
    protocol    = "tcp"
    cidr_blocks = ["103.173.197.192/32"]  
  }

  ingress {
    from_port   = 80
    to_port     = 80
    protocol    = "tcp"
    cidr_blocks = ["23.226.124.100/32"]  
  }

  egress {
    from_port   = 0
    to_port     = 0
    protocol    = "-1"  
    cidr_blocks = ["0.0.0.0/0"]
  }
  
  tags = {
    Name = "TestSG"
  }
}

resource "aws_instance" "test_Server" {
  ami = "ami-0e53db6fd757e38c7"
  instance_type = "t2.micro"
  key_name = "test-key"
  vpc_security_group_ids = [aws_security_group.test_sg.id]

  user_data = <<-EOF
    #!/bin/bash
    sudo yum update
    sudo yum install -y nginx yum-utils device-mapper-persistent-data lvm2 docker 
    sudo systemctl start nginx
    sudo systemctl enable nginx
    sudo systemctl start docker
    sudo systemctl enable docker                
    sudo curl -L "https://github.com/docker/compose/releases/download/v2.20.0/docker-compose-$(uname -s)-$(uname -m)" -o /usr/local/bin/docker-compose
    sudo chmod +x /usr/local/bin/docker-compose    
  EOF

  tags = {
    Name = "TestServer"
  }
}

output "instance_public_ip" {
  description = "The public IP of the instance"
  value       = aws_instance.test_Server.public_ip
}
