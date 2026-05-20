resource "scaleway_instance_security_group" "traefik_sg" {
  name                    = "homelab-sg"
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
}

resource "scaleway_instance_ip" "traefik_instance_ip" {
  project_id = scaleway_account_project.gitea_project.id
}

resource "scaleway_instance_server" "traefik_instance" {
  name              = "traefik"
  type              = "STARDUST1-S"
  image             = local.image
  ip_id             = scaleway_instance_ip.traefik_instance_ip.id
  security_group_id = scaleway_instance_security_group.traefik_sg.id
  project_id        = scaleway_account_project.gitea_project.id

  private_network {
    pn_id = scaleway_vpc_private_network.homelab_pn.id
  }

  tags = ["managed-by:opentofu"]
}
