terraform {
  required_providers {
    cloudflare = {
      source = "cloudflare/cloudflare"
      version = "~> 3.0"
    }
  }
}

provider "cloudflare" {
  api_token = var.cloudflare_key
}

data "cloudflare_zone" "this" {
  name = "voutuk.pp.ua"
}

provider "aws" {
  access_key = var.aws_acces_key
  secret_key = var.aws_secret_key
  region = "eu-north-1"
}


resource "aws_instance" "ec2_instance" {
  availability_zone = "eu-north-1a"
  ami = "ami-0014ce3e52359afbd"
  instance_type = "t3.micro"
  key_name = "312123312"
  vpc_security_group_ids = [aws_security_group.default.id]
  ebs_block_device {
    device_name = "/dev/sda1"
    volume_size = 15
    volume_type = "standard"
    tags = {device_name = "Test"}
  }
  tags = {
    Name = "Agar-server1s"
  }
  user_data = "wget -qO- https://raw.githubusercontent.com/voutuk/file/main/swap.sh | sudo bash"
}
resource "aws_security_group" "default" {
  ingress{
    from_port = 22
    to_port = 22
    protocol = "tcp"
    cidr_blocks = ["0.0.0.0/0"]
  }
  egress{
    from_port = 0
    to_port = 0
    protocol = "-1"
    cidr_blocks = ["0.0.0.0/0"]
  }
}

resource "cloudflare_record" "foobar" {
  zone_id = data.cloudflare_zone.this.id
  name    = "test"
  value   = aws_instance.ec2_instance.public_ip
  type    = "A"
  proxied = false
}

output "record" {
  value = cloudflare_record.foobar.hostname
}

output "metadata" {
  value       = cloudflare_record.foobar.metadata
  sensitive   = true
}