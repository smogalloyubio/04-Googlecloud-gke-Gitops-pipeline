variable "org" {}
variable "environment" {}
variable "region" {}
variable "instance_ids" {
  type = list(string)
}
variable "cpu_threshold" {
  type    = number
  default = 80
}
