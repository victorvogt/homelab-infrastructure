resource "scaleway_account_project" "gitea_project" {
  name        = "homelab-${local.environment}"
  description = "Homelab ${local.environment} environment"
}

moved {
  from = scaleway_account_project.this
  to   = scaleway_account_project.gitea_project
}
