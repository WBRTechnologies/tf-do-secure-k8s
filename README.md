# Secure DigitalOcean Kubernetes Cluster – Terraform Module

## Description

This Terraform module provisions a fully secured Kubernetes environment on DigitalOcean, delivering a private Kubernetes cluster with an internal-only NGINX ingress controller, integrated private registry authentication for controlled image pulls, and an OpenVPN server that provides encrypted, restricted access into the cluster.

## Why This Exists

This module is designed for anyone who requires a purpose-built private server with tightly controlled access, suitable for backend administration systems, financial platforms, trading engines, banking workloads, regulatory applications, and any environment that must operate exclusively within a private network with no internet-facing components and never be publicly exposed.

This setup ensures:

- The Kubernetes API is private
- Ingress is strictly internal
- Workloads are unreachable from the public internet
- Cluster access is gated through a dedicated OpenVPN server
- Private registry credentials protect image pulls

It provides a controlled, isolated, production-ready environment for critical systems where security and privacy are essential.

## Prerequisites

Install the following tools locally:

- Terraform v1.x
- kubectl
- Helm
- Make (recommended)

Export the required environment variables before running:

```bash
export TF_VAR_docker_registry_server="registry.example.com"
export TF_VAR_docker_registry_username="your-username"
export TF_VAR_docker_registry_password="your-token"
export TF_VAR_openvpn_admin_password="password-for-openvpn-admin-user"
```

These variables must be set before provisioning.

## Installation

### Using Terraform directly

```bash
terraform init
terraform plan
terraform apply
```

### Using the Makefile (Recommended)

```bash
make up
```

This automates:

- Terraform initialization
- Terraform apply
- kubeconfig setup

⚠️ Note: `make up` and `make set-kubeconfig` overwrite the kubeconfig at `~/.kube/config`. Back up the file first if you manage multiple clusters.

## Usage

After provisioning is complete:

1. Retrieve the OpenVPN server’s public IP from the Terraform outputs.
2. Download the generated `.ovpn` profile.
3. Import the profile into an OpenVPN client (macOS, Windows, Linux, iOS, Android).
4. Connect to the VPN.
5. Access Kubernetes workloads through their internal-only ingress endpoints.

### Using your private Docker registry in Helm charts

```yaml
imagePullSecrets:
  - name: docker-credentials
```

This ensures your workloads can pull private images securely within the cluster.

## Uninstallation

To remove all provisioned infrastructure:

```bash
terraform destroy
```
