terraform {
  required_providers {
    kubernetes = {
      source  = "hashicorp/kubernetes"
      version = "~> 2.23.0"
    }
  }
}

provider "kubernetes" {
  config_path = var.kube_config_path
}

resource "kubernetes_deployment" "sample_app" {
  metadata {
    name = "sample-app"
    labels = {
      app = "sample-app"
    }
  }

  spec {
    replicas = 2

    selector {
      match_labels = {
        app = "sample-app"
      }
    }

    template {
      metadata {
        labels = {
          app = "sample-app"
        }
      }

      spec {
        container {
          name  = "sample-app"
          image = "nginx:latest"
          port {
            container_port = 80
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

resource "kubernetes_service" "sample_app" {
  metadata {
    name = "sample-app"
    labels = {
      app = "sample-app"
    }
  }

  spec {
    type = "ClusterIP"
    port {
      port        = 80
      target_port = 80
      protocol    = "TCP"
      name        = "http"
    }

    selector = {
      app = "sample-app"
    }
  }
} 