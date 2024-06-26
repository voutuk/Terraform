// terraform apply -var-file="secrets.tfvars" -auto-approve
// terraform destroy -var-file="secrets.tfvars" -auto-approve
// terraform init
variable "aws_secret" {}     //AWS
variable "aws_acces" {}      //AWS
variable "cloudflare_api" {} //Cloudflare

terraform {
  required_providers {
    aws = {
      source  = "hashicorp/aws"
      version = "~> 3.0"
    }
    cloudflare = {
      source  = "cloudflare/cloudflare"
      version = "~> 3.0"
    }
  }
}

provider "aws" {
  access_key = var.aws_acces  //key
  secret_key = var.aws_secret //key
  //profile    = "sso-session Terraform" //AWS SSO
  region     = "eu-north-1"
}
provider "cloudflare" {
  api_token = var.cloudflare_api
}

data "cloudflare_zone" "this" {
  name = "voutuk.site" //EDIT
}

// EC2
resource "aws_instance" "AWS-3" {
  availability_zone      = "eu-north-1a"
  ami                    = "ami-0014ce3e52359afbd"
  instance_type          = "t3.micro"
  key_name               = "BublikKEY"
  iam_instance_profile   = "BUBLIK-S3" //instance role
  vpc_security_group_ids = [aws_security_group.AWS-3.id]
  ebs_block_device {
    encrypted = true
    device_name = "/dev/sda1"
    volume_size = 10
    volume_type = "standard"
    tags        = { device_name = "Terraform" }
  }
  tags = {
    Name = "APACHE-UB-3"
  }
  provisioner "file" {
    source      = "${path.module}/script.sh"
    destination = "/tmp/script.sh"
  }
  provisioner "remote-exec" {
    inline = [
      "chmod +x /tmp/script.sh",
      "sudo bash /tmp/script.sh",
    ]
  }
  connection {
    type        = "ssh"
    user        = "ubuntu"
    password    = ""
    private_key = file("${path.module}/BublikKEY.pem") //SSH KEY
    host        = self.public_ip
  }
}

resource "aws_security_group" "AWS-3" {
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

// Cloudflare
resource "cloudflare_record" "foobar" {
  zone_id = data.cloudflare_zone.this.id
  name    = "foobar"
  value   = aws_instance.AWS-3.public_ip
  type    = "A"
  proxied = true
}

output "record" {
  value = cloudflare_record.foobar.hostname
}