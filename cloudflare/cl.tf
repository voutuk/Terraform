// terraform apply -var-file=secrets.tfvars
variable "cloud_api_key" {}

terraform {
  required_providers {
    cloudflare = {
      source = "cloudflare/cloudflare"
      version = "~> 3.0"
    }
  }
}

provider "cloudflare" {
  api_token = var.cloud_api_key
}

data "cloudflare_zone" "this" {
  name = "voutuk.pp.ua"
}

resource "cloudflare_record" "foobar" {
  zone_id = data.cloudflare_zone.this.id
  name    = "foobar"
  value   = "127.0.0.1"
  type    = "A"
  proxied = false
}

output "record" {
  value = cloudflare_record.foobar.hostname
}