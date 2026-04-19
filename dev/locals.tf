locals {
  region        = "fr-par"
  zone          = "fr-par-1"
  environment   = "dev"
  instance_type = "DEV1-S"
  image         = "debian_trixie"

  allowed_ip_range = "88.138.79.90/32"
}
