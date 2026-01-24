# Root module variables
project_id = "ubioworo-project"
zone    = "us-central1-a"
region= "us-central1"

# Network module variables
network_name = "gke-vpc"
subnet_name  = "gke-subnet"
subnet_cidr  = "10.10.0.0/16"

# Compute module variables (GKE cluster)
cluster_name = "gke-cluster"
node_count   = 1        
machine_type = "e2-micro"  
preemptible  = true       