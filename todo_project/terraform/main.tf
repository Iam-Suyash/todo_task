provider "aws" {
    region = "us-east-1"
}

resource "aws_security_group" "demo_project" {
    name = "demo_project_sg"
    description = "Allow SSH, HTTP and HTTPS inbound traffic"
    vpc_id = data.aws_vpc.default.id

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

    egress {
    from_port   = 0
    to_port     = 0
    protocol    = "-1"
    cidr_blocks = ["0.0.0.0/0"]
    }

}

data "aws_vpc" "default" {
    default = true
}

# data "aws_subnet" "default" {
#     filter {
#       name = "vpc-id"
#       values = [data.aws_vpc.default.id]
#     }
# }

resource "aws_instance" "project" {
    ami           = "ami-0360c520857e3138f"
    instance_type = var.instance_type
    key_name = var.key_name
    # subnet_id = data.aws_subnet.default.id
    vpc_security_group_ids = [aws_security_group.demo_project.id]
    associate_public_ip_address = true  

    user_data = <<-EOF
        sudo apt update
        sudo apt install fontconfig openjdk-21-jre
        java -version

        sudo wget -O /etc/apt/keyrings/jenkins-keyring.asc \
        https://pkg.jenkins.io/debian/jenkins.io-2023.key
        echo "deb [signed-by=/etc/apt/keyrings/jenkins-keyring.asc]" \
        https://pkg.jenkins.io/debian binary/ | sudo tee \
        /etc/apt/sources.list.d/jenkins.list > /dev/null
        sudo apt-get update
        sudo apt-get install jenkins
        EOF
    
    tags = {
        Name = "ec2-project"
    }
}

