terraform {
  required_providers {
    scaleway = {
      source  = "scaleway/scaleway"
      version = "~> 2.46"
    }
  }
  required_version = ">= 1.7"
}

provider "scaleway" {
  region = local.region
  zone   = local.zone
}
