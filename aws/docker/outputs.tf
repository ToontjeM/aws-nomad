output "docker_server_public_ips" {
  value = module.docker_server[*].public_ip
}

#output "nomad_client_public_ips" {
#  value = module.nomad_client[*].public_ip
#}

output "docker_server_private_ips" {
  value = module.docker_server[*].private_ip
}
