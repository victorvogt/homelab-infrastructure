output "id" {
  value       = scaleway_instance_server.this.id
  description = "Instance ID"
}

output "public_ip" {
  value       = scaleway_instance_ip.this.address
  description = "Public IPv4 address"
}

output "private_ip" {
  value       = try(scaleway_instance_server.this.private_ips[0].address, null)
  description = "Private IP address"
}
