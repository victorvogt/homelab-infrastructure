resource "scaleway_account_project" "gitea_project" {
  name        = "homelab-${local.environment}"
  description = "Homelab ${local.environment} environment"
}
