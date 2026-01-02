output "master_instance_ids" {
  value = aws_instance.master[*].id
}

output "worker_instance_ids" {
  value = aws_instance.worker[*].id
}

output "master_public_ips" {
  value = aws_instance.master[*].public_ip
}

output "worker_public_ips" {
  value = aws_instance.worker[*].public_ip
}
