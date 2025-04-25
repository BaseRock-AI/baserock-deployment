#!/bin/bash

source ./commons/messaging.sh

# Function to check if Docker is running
check_docker() {
    if ! docker info > /dev/null 2>&1; then
        print_status "Docker is not running. Please start Docker and try again."
        exit 1
    fi
}

# Ensure Docker is running
check_docker

print_status "Cleaning up minikube..."
minikube delete
print_status "Starting Minikube..."
minikube start --memory=4096 --cpus=3 --driver=docker || exit 1

print_status "Switching context"
kubectl config use-context minikube

./commons/namespace-setup.sh

print_status "Cleaning up existing chart dependencies..."
rm -rf ./baserock-backend/charts


# Wait until Minikube is fully started
if ! minikube status | grep -q "Running"; then
    print_status "Minikube failed to start. Exiting."
    exit 1
fi

# Enable Ingress only if Minikube is running
print_status "Enabling Ingress addon..."
minikube addons enable ingress || exit 1

print_status "Creating namespace: $NAMESPACE"
kubectl create namespace $NAMESPACE || true

print_status "Minikube setup completed successfully!"
