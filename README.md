# GitOps Kubernetes Deployment with Spacelift

This repository demonstrates a GitOps pipeline for Kubernetes deployment using Spacelift.

## Repository Structure

```
.
├── manifests/
│   ├── deployment.yaml    # Kubernetes deployment manifest
│   └── service.yaml       # Kubernetes service manifest
├── spacelift.yaml         # Spacelift configuration
└── README.md              # This file
```

## Setup Instructions

1. **Prerequisites**
   - A Kubernetes cluster
   - Spacelift account
   - Git repository

2. **Configure Spacelift**
   - Create a new stack in Spacelift
   - Connect it to this Git repository
   - Set the following environment variables:
     - `GIT_REPO_URL`: Your Git repository URL
     - `KUBE_CONFIG`: Your Kubernetes configuration

3. **Deployment**
   - Push changes to the main branch
   - Spacelift will automatically deploy the changes to your Kubernetes cluster

## Kubernetes Resources

- Deployment: 2 replicas of nginx
- Service: ClusterIP type exposing port 80

## Notes

- The deployment uses resource limits and requests
- The service is configured as ClusterIP
- All changes to the manifests will trigger automatic deployments 