variable "kubernetes_host" {
  description = "The hostname (in form of URI) of Kubernetes master"
  type        = string
}

variable "kubernetes_cluster_ca_certificate" {
  description = "PEM-encoded root certificates bundle for TLS authentication"
  type        = string
}

variable "google_project" {
  description = "The Google Cloud project ID"
  type        = string
  default     = "ldt-contact-form"
}

variable "google_region" {
  description = "The Google Cloud region"
  type        = string
  default     = "europe-central2"
} 