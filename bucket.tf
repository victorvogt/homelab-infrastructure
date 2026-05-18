resource "scaleway_object_bucket" "gitea_backups" {
  name       = "homelab-gitea-backups"
  project_id = scaleway_account_project.gitea_project.id
  region     = local.region

  tags = {
    managed-by  = "opentofu"
    purpose     = "gitea-backups"
  }

  versioning {
    enabled = false
  }

  lifecycle_rule {
    id      = "default"
    enabled = true

    expiration {
      days = 30
    }
  }
}

resource "scaleway_iam_application" "gitea_backups" {
  name        = "homelab-gitea-backups-app"
  description = "Application for gitea backups bucket access"
}

resource "scaleway_iam_policy" "gitea_backups" {
  name           = "homelab-gitea-backups-policy"
  description    = "Grants object storage access for gitea backups"
  application_id = scaleway_iam_application.gitea_backups.id

  rule {
    project_ids          = [scaleway_account_project.gitea_project.id]
    permission_set_names = ["ObjectStorageFullAccess"]
  }
}

resource "scaleway_iam_api_key" "gitea_backups" {
  application_id     = scaleway_iam_application.gitea_backups.id
  description        = "API key for gitea backups bucket"
  default_project_id = scaleway_account_project.gitea_project.id

  expires_at = "${formatdate("YYYY", time_static.gitea_backups.rfc3339)}-12-31T23:59:59Z"

  depends_on = [scaleway_iam_policy.gitea_backups]
}

resource "time_static" "gitea_backups" {}
