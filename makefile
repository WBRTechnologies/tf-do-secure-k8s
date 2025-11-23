# Makefile for Terraform + Kubernetes workflow

TF              ?= terraform
KUBECONFIG_PATH ?= ~/.kube/config

.PHONY: init apply set-kubeconfig up

# Initialize Terraform
init:
	@echo "🚀 Initializing Terraform..."
	$(TF) init

# Apply Terraform configuration
apply:
	@echo "⚙️ Applying Terraform configuration..."
	$(TF) apply -auto-approve

# Set kubeconfig from Terraform output
set-kubeconfig:
	@echo "🔐 Generating kubeconfig and saving to $(KUBECONFIG_PATH)..."
	mkdir -p ~/.kube
	$(TF) output -raw kubeconfig > $(KUBECONFIG_PATH)

# Full provisioning flow: init + apply + set-kubeconfig
up: init apply set-kubeconfig
