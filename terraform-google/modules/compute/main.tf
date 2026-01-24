resource "google_container_cluster" "gke_cluster" {
  name     = var.cluster_name
  location = var.zone


  initial_node_count = 1

  network    = var.network_id
  subnetwork = var.subnet_id

  remove_default_node_pool = true
}

resource "google_container_node_pool" "primary_nodes" {
  name       = "${var.cluster_name}-node-pool"
  cluster    = google_container_cluster.gke_cluster.name
  location   = var.zone
  node_count = var.node_count  

  node_config {
    machine_type = var.machine_type   
    preemptible  = var.preemptible   
    disk_size_gb = 20           
    oauth_scopes = [
      "https://www.googleapis.com/auth/cloud-platform"
    ]
  }
}