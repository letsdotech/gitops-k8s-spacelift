variable "kube_config_path" {
  description = "Path to the kubeconfig file"
  type        = string
  default     = "~/.kube/config"
}

variable "kubernetes_host" {
  description = "The hostname (in form of URI) of Kubernetes master"
  type        = string
}

variable "kubernetes_client_certificate" {
  description = "PEM-encoded client certificate for TLS authentication"
  type        = string
}

variable "kubernetes_client_key" {
  description = "PEM-encoded client certificate key for TLS authentication"
  type        = string
}

variable "kubernetes_cluster_ca_certificate" {
  description = "PEM-encoded root certificates bundle for TLS authentication"
  type        = string
} 