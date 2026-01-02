# General
org         = "acme"
environment = "prod"
aws_region  = "us-east-1"

# Network
vpc_cidr          = "10.0.0.0/16"
subnet_cidr       = "10.0.1.0/24"
availability_zone = "us-east-1a"

# Compute
instance_type = "t3.medium"

# Admin user for EC2
admin_username = "admin"
admin_password = "admin123"
app_role = "web"

