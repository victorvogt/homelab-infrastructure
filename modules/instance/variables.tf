variable "name" {
  type        = string
  description = "Instance name"
}

variable "instance_type" {
  type        = string
  default     = "PLAY2-PICO"
  description = "Scaleway instance type"
}

variable "image" {
  type        = string
  default     = "ubuntu_jammy"
  description = "Instance image"
}

variable "security_group_id" {
  type        = string
  description = "Security group ID to attach"
}

variable "project_id" {
  type        = string
  description = "Scaleway project ID"
}

variable "tags" {
  type        = list(string)
  default     = []
  description = "Instance tags"
}
