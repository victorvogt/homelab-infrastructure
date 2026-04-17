resource "scaleway_instance_ip" "this" {
  project_id = var.project_id
}

resource "scaleway_instance_server" "this" {
  name              = var.name
  type              = var.instance_type
  image             = var.image
  ip_id             = scaleway_instance_ip.this.id
  security_group_id = var.security_group_id
  project_id        = var.project_id

  tags = var.tags
}
