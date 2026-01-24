variable "cluster_name" {
  type        = string
  description = "GKE cluster name"
}

variable "region" {
  type        = string
  description = "GCP region"
}

variable "node_count" {
  type        = number
  description = "Number of nodes in the pool"
}

variable "machine_type" {
  type        = string
  description = "GCE machine type"
}

variable "preemptible" {
  type        = bool
  description = "Whether nodes are preemptible"
}

variable "network_id" {
  type = string
}

variable "subnet_id" {
  type = string
}

variable "zone" {
  type = string
}