# Lookup the latest Ubuntu AMI in the root

module "network" {
  source = "./modules/network"   # path to your network module folder

  org               = var.org
  environment       = var.environment
  region            = var.aws_region
  vpc_cidr          = var.vpc_cidr
  subnet_cidr       = var.subnet_cidr
  availability_zone = var.availability_zone
}




data "aws_ami" "ubuntu" {
  most_recent = true
  owners      = ["099720109477"] # Canonical

  filter {
    name   = "name"
    values = ["ubuntu/images/hvm-ssd/ubuntu-jammy-22.04-amd64-server-*"]
  }

  filter {
    name   = "virtualization-type"
    values = ["hvm"]
  }
}

module "compute" {
  source = "./modules/compute"

  org                = var.org
  environment        = var.environment
  region             = var.aws_region
  ami_id             = data.aws_ami.ubuntu.id   
  instance_type      = var.instance_type
  subnet_id          = module.network.subnet_id
  security_group_id  = module.network.security_group_id
  admin_username     = var.admin_username
  admin_password     = var.admin_password
  master_count       = 1
  worker_count       = 2
}


module "monitoring" {
  source = "./modules/monitoring"
  org           = var.org
  environment   = var.environment
  region        = var.aws_region
  instance_ids  = concat(module.compute.master_instance_ids, module.compute.worker_instance_ids)
  cpu_threshold = 80
}

# Root-level SSH key (TLS-generated) and AWS key pair for SSH access
resource "tls_private_key" "ssh_key" {
  algorithm = "RSA"
  rsa_bits  = 4096
}

resource "aws_key_pair" "deployer" {
  key_name   = "${var.org}-${var.environment}-deployer"
  public_key = tls_private_key.ssh_key.public_key_openssh
}

