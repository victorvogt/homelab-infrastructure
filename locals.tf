locals {
  region        = "fr-par"
  zone          = "fr-par-1"
  environment   = "dev"
  instance_type = "DEV1-S"
  image         = "debian_trixie"

  allowed_ip_range = "0.0.0.0/32" # Placeholder, replace with your actual IP range for security group rules
}
