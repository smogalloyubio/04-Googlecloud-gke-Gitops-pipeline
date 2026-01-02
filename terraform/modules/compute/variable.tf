variable "ami_id" {}
variable "instance_type" {}
variable "subnet_id" {}
variable "security_group_id" {}
variable "admin_username" {}
variable "admin_password" {}
variable "master_count" { default = 1 }
variable "worker_count" { default = 2 }
variable "org" {}
variable "environment" {}
variable "region" {}
