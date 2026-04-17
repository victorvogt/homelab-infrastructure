variable "name" {
  type        = string
  description = "Security group name"
}

variable "description" {
  type        = string
  default     = ""
  description = "Security group description"
}

variable "project_id" {
  type        = string
  description = "Scaleway project ID"
}

variable "inbound_rules" {
  type = list(object({
    action   = string
    protocol = string
    port     = number
    ip_range = optional(string, "0.0.0.0/0")
  }))
  description = "List of inbound rules"
}
