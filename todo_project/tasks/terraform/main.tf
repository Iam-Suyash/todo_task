provider "aws" {
    region = "us-east-1"
}

resource "aws_security_group" "demo_project" {
    name = "demo_project_sg"
    description = "Allow SSH, HTTP and HTTPS inbound traffic"
    vpc_id = deta.aws_vpc.default.id

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

    ingress {
        from_port   = 443
        to_port     = 443
        protocol    = "tcp"
        cidr_blocks = ["0.0.0.0/0"]
    }

}

data "aws_vpc" "default" {
    default = true
}

data "aws_subnet" "default" {
    filter {
      name = "vpc-id"
      values = [data.aws_vpc.default.id]
    }
}

resource "aws_instance" "project" {
    ami           = "ami-0360c520857e3138f"
    instance_type = "var.instance_type"
    key_name = "var.key_name"
    subnet_id = data.aws_subnet.default.id[0]
    vpc_security_group_ids = [aws_security_group.demo_project.id]
    
    tags = {
        Name = "ec2-project"
    }
}

