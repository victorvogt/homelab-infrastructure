resource "scaleway_vpc" "homelab_vpc" {
  name       = "homelab-vpc"
  project_id = scaleway_account_project.gitea_project.id
  tags       = ["managed-by:opentofu"]
}

resource "scaleway_vpc_private_network" "homelab_pn" {
  name       = "homelab-private-network"
  vpc_id     = scaleway_vpc.homelab_vpc.id
  project_id = scaleway_account_project.gitea_project.id
  tags       = ["managed-by:opentofu"]
}
