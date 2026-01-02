output "vpc_id" {
  value = module.network.vpc_id
}

output "master_public_ip" {
  value = module.compute.master_public_ips[0]
}

output "worker_public_ips" {
  value = module.compute.worker_public_ips
}

output "ssh_private_key_pem" {
  value     = tls_private_key.ssh_key.private_key_pem
  sensitive = true
}

