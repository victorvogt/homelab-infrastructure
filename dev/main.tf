resource "scaleway_account_project" "this" {
  name        = "homelab-dev"
  description = "Homelab development environment"
}

module "security_group" {
  source = "../modules/security_group"

  name        = "${local.environment}-sg"
  description = "Security group for ${local.environment} environment"
  project_id  = scaleway_account_project.this.id

  inbound_rules = [
    { action = "accept", protocol = "TCP", port = 22, ip_range = local.allowed_ip_range},
    { action = "accept", protocol = "TCP", port = 80, ip_range = local.allowed_ip_range},
    { action = "accept", protocol = "TCP", port = 443, ip_range = local.allowed_ip_range},
    { action = "accept", protocol = "TCP", port = 30022, ip_range = local.allowed_ip_range},
  ]
}

module "instance" {
  source = "../modules/instance"

  name              = "${local.environment}-server"
  instance_type     = local.instance_type
  image             = local.image
  security_group_id = module.security_group.id
  project_id        = scaleway_account_project.this.id
  tags              = ["environment:${local.environment}", "managed-by:opentofu"]
}
