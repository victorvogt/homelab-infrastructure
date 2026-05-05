resource "scaleway_instance_security_group" "gitea_instance_sg" {
  name                    = "${local.environment}-sg"
  description             = "Security group for ${local.environment} environment"
  project_id              = scaleway_account_project.gitea_project.id
  inbound_default_policy  = "drop"
  outbound_default_policy = "accept"

  inbound_rule {
    action   = "accept"
    protocol = "TCP"
    port     = 22
    ip_range = local.allowed_ip_range
  }

  inbound_rule {
    action   = "accept"
    protocol = "TCP"
    port     = 80
    ip_range = local.allowed_ip_range
  }

  inbound_rule {
    action   = "accept"
    protocol = "TCP"
    port     = 443
    ip_range = local.allowed_ip_range
  }

  inbound_rule {
    action   = "accept"
    protocol = "TCP"
    port     = 30022
    ip_range = local.allowed_ip_range
  }
}

resource "scaleway_instance_ip" "gitea_instance_ip" {
  project_id = scaleway_account_project.gitea_project.id
}

resource "scaleway_instance_server" "gitea_instance" {
  name              = "${local.environment}-server"
  type              = local.instance_type
  image             = local.image
  ip_id             = scaleway_instance_ip.gitea_instance_ip.id
  security_group_id = scaleway_instance_security_group.gitea_instance_sg.id
  project_id        = scaleway_account_project.gitea_project.id

  tags = ["environment:${local.environment}", "managed-by:opentofu"]
}

moved {
  from = module.instance.scaleway_instance_ip.this
  to   = scaleway_instance_ip.gitea_instance_ip
}

moved {
  from = module.security_group.scaleway_instance_security_group.this
  to   = scaleway_instance_security_group.gitea_instance_sg
}

moved {
  from = module.instance.scaleway_instance_server.this
  to   = scaleway_instance_server.gitea_instance
}
