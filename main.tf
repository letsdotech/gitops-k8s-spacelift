terraform {
  required_providers {
    kubernetes = {
      source  = "hashicorp/kubernetes"
      version = "~> 2.23.0"
    }
  }
}

provider "kubernetes" {
  host                   = var.kubernetes_host
  cluster_ca_certificate = base64decode(var.kubernetes_cluster_ca_certificate)
  token                  = data.google_client_config.current.access_token
}

data "google_client_config" "current" {}

# Calculator Server Deployment
resource "kubernetes_deployment" "calculator_server" {
  metadata {
    name = "calculator-server"
    labels = {
      app = "calculator-server"
    }
  }

  spec {
    replicas = 2

    selector {
      match_labels = {
        app = "calculator-server"
      }
    }

    template {
      metadata {
        labels = {
          app = "calculator-server"
        }
      }

      spec {
        node_selector = {
          "kubernetes.io/arch" = "amd64"
        }
        
        container {
          name  = "calculator-server"
          image = "letsdotech/calculator-server:v1.0.3"
          port {
            container_port = 8080
          }

          readiness_probe {
            http_get {
              path = "/health"
              port = 8080
            }
            initial_delay_seconds = 5
            period_seconds        = 10
          }

          liveness_probe {
            http_get {
              path = "/health"
              port = 8080
            }
            initial_delay_seconds = 15
            period_seconds        = 20
          }

          resources {
            requests = {
              cpu    = "100m"
              memory = "128Mi"
            }
            limits = {
              cpu    = "200m"
              memory = "256Mi"
            }
          }
        }
      }
    }
  }
}

# Calculator Server Service
resource "kubernetes_service" "calculator_server" {
  metadata {
    name = "calculator-server"
    labels = {
      app = "calculator-server"
    }
  }

  spec {
    type = "ClusterIP"
    port {
      port        = 8080
      target_port = 8080
      protocol    = "TCP"
      name        = "http"
    }

    selector = {
      app = "calculator-server"
    }
  }
}

# Dummy Client Deployment
resource "kubernetes_deployment" "dummy_client" {
  metadata {
    name = "dummy-client"
    labels = {
      app = "dummy-client"
    }
  }

  spec {
    replicas = 2

    selector {
      match_labels = {
        app = "dummy-client"
      }
    }

    template {
      metadata {
        labels = {
          app = "dummy-client"
        }
      }

      spec {
        node_selector = {
          "kubernetes.io/arch" = "amd64"
        }
        
        container {
          name  = "dummy-client"
          image = "letsdotech/dummy-client:v1.0.2"
          port {
            container_port = 8080
          }

          readiness_probe {
            http_get {
              path = "/health"
              port = 8080
            }
            initial_delay_seconds = 5
            period_seconds        = 10
          }

          liveness_probe {
            http_get {
              path = "/health"
              port = 8080
            }
            initial_delay_seconds = 15
            period_seconds        = 20
          }

          resources {
            requests = {
              cpu    = "100m"
              memory = "128Mi"
            }
            limits = {
              cpu    = "200m"
              memory = "256Mi"
            }
          }
        }
      }
    }
  }
}

# Dummy Client Service
resource "kubernetes_service" "dummy_client" {
  metadata {
    name = "dummy-client"
    labels = {
      app = "dummy-client"
    }
  }

  spec {
    type = "ClusterIP"
    port {
      port        = 8080
      target_port = 8080
      protocol    = "TCP"
      name        = "http"
    }

    selector = {
      app = "dummy-client"
    }
  }
} 