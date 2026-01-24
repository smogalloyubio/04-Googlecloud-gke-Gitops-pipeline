
# Network module
module "network" {
  source       = "./modules/network"
  network_name = "gke-vpc"
  subnet_name  = "gke-subnet"
  subnet_cidr  = "10.10.0.0/16"
  region       = var.region
  zone        = var.zone
}

# Compute module (GKE)
module "compute" {
  source       = "./modules/compute"
  cluster_name = "gke-cluster"
  zone         = var.zone
  region       = var.region
  node_count   = 1
  machine_type = "e2-medium"
  preemptible  = false
  network_id   = module.network.network_id
  subnet_id    = module.network.subnet_id
}