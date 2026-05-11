terraform {
  backend "s3" {
    bucket                      = "vv-homelab-tfstate"
    key                         = "homelab.tfstate"
    region                      = local.region
    endpoints                   = { s3 = "https://s3.fr-par.scw.cloud" }

    use_path_style              = true
    skip_credentials_validation = true
    skip_region_validation      = true
    skip_requesting_account_id  = true # Essential for TF 1.6+
    skip_metadata_api_check     = true
    skip_s3_checksum            = true # Scaleway doesn't support S3's new checksum headers
  }
}
