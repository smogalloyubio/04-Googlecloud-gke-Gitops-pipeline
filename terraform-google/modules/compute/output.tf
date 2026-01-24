
output "cluster_name" {
  value = google_container_cluster.gke_cluster.name
}

output "endpoint" {
  value = google_container_cluster.gke_cluster.endpoint
}

output "kubeconfig" {
  value = google_container_cluster.gke_cluster.endpoint
}