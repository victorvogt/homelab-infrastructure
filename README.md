# homelab-infrastructure

Infrastructure as Code for a self-hosted homelab on [Scaleway](https://www.scaleway.com/), managed with [OpenTofu](https://opentofu.org/).

## Overview

Provisions a **Gitea** instance on Scaleway with automated S3 backups and a dedicated IAM setup.

```
Scaleway Project (homelab)
├── Instance (DEV1-S · Debian Trixie · fr-par-1)
│   └── Security Group (SSH, HTTP, HTTPS, Gitea SSH — IP allowlist)
├── Object Storage Bucket (gitea backups · 30-day retention)
└── IAM Application + Policy + API Key (scoped to backup bucket)
```

## Stack

| Tool | Purpose |
|------|---------|
| [OpenTofu](https://opentofu.org/) ≥ 1.7 | IaC runtime |
| [scaleway/scaleway](https://registry.terraform.io/providers/scaleway/scaleway/latest) ~> 2.46 | Scaleway provider |
| Scaleway S3 | Remote state backend + backup storage |

## Resources

| Resource | Type | Details |
|----------|------|---------|
| `gitea_project` | `scaleway_account_project` | Scaleway project scoping all resources |
| `gitea_instance` | `scaleway_instance_server` | DEV1-S, Debian Trixie, fr-par-1 |
| `gitea_instance_sg` | `scaleway_instance_security_group` | Allowlist-only inbound (22, 80, 443, 30022) |
| `gitea_instance_ip` | `scaleway_instance_ip` | Static public IP |
| `gitea_backups` | `scaleway_object_bucket` | S3 bucket, 30-day lifecycle, fr-par |
| `gitea_backups` | `scaleway_iam_application` | Dedicated app for backup access |
| `gitea_backups` | `scaleway_iam_policy` | `ObjectStorageFullAccess` on the project |
| `gitea_backups` | `scaleway_iam_api_key` | Expires end-of-year, auto-provisioned |

## Prerequisites

- OpenTofu ≥ 1.7
- Scaleway account with API credentials
- A `vv-homelab-tfstate` S3 bucket on Scaleway (for remote state)

## Usage

**1. Configure backend credentials**

Create a `backend.hcl` file (never commit this):

```hcl
access_key = "<SCW_ACCESS_KEY>"
secret_key = "<SCW_SECRET_KEY>"
```

**2. Set provider credentials**

```bash
export SCW_ACCESS_KEY="<your-access-key>"
export SCW_SECRET_KEY="<your-secret-key>"
```

**3. Initialize and apply**

```bash
tofu init -backend-config=backend.hcl
tofu plan
tofu apply
```

## Configuration

Key values are defined in [`locals.tf`](locals.tf):

| Local | Value | Description |
|-------|-------|-------------|
| `region` | `fr-par` | Scaleway region |
| `zone` | `fr-par-1` | Scaleway zone |
| `environment` | `dev` | Environment tag |
| `instance_type` | `DEV1-S` | Instance size |
| `image` | `debian_trixie` | OS image |
| `allowed_ip_range` | `x.x.x.x/32` | IP allowlist for inbound rules |

## State

Remote state is stored in Scaleway Object Storage:

- **Bucket**: `vv-homelab-tfstate`
- **Key**: `homelab-infrastructure/terraform.dev.tfstate`
- **Region**: `fr-par`
