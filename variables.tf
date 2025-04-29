variable "kubernetes_host" {
  description = "The hostname (in form of URI) of Kubernetes master"
  type        = string
}

variable "kubernetes_cluster_ca_certificate" {
  description = "PEM-encoded root certificates bundle for TLS authentication"
  type        = string
} 