terraform {
  required_providers {
    cloudflare = {
      source = "cloudflare/cloudflare"
      version = "~> 3.0"
    }
  }
}

provider "cloudflare" {
  api_token = "LaDFPET5DN8uWbBtjeCDikKmri2RjM2BCdc5ze0N"
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

output "metadata" {
  value       = cloudflare_record.foobar.metadata
  sensitive   = true
}