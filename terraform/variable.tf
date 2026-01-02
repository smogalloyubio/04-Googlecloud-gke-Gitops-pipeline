variable "org" {
  description = "Organization name"
  type        = string
}

variable "environment" {
  description = "Environment (dev, staging, prod)"
  type        = string
}

variable "app_role" {
  description = "Application role (web, app, db)"
  type        = string
  default = "web"
}

variable "aws_region" {
  description = "AWS region"
  type        = string
}

variable "aws_az" {
  description = "AWS availability zone (e.g. us-east-1a)"
  type        = string
  default = "us-east-1a"
}

variable "vpc_cidr" {
  description = "VPC CIDR block"
  type        = string
}

variable "instance_type" {
  description = "EC2 instance type for master and workers"
  type        = string
}

variable "admin_username" {
  description = "Local admin username for bootstrapping scripts"
  type        = string
  default     = "ubuntu"
}

variable "admin_password" {
  description = "Local admin password for bootstrapping scripts"
  type        = string
  sensitive   = true
}

variable "subnet_cidr" {
  description = "Subnet CIDR block"
  type        = string
  default     = "10.10.1.0/24"
}

variable "availability_zone" {
  description = "AWS availability zone for subnet"
  type        = string
  default     = "us-east-1a"
}

variable "ami_id" {
  description = "AMI ID for EC2 instances"
  type        = string
  default     = "ami-0ecb62995f68bb549"
}