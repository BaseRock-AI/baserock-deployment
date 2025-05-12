#!/bin/bash

# Prompt for sudo password at the start
echo "Enter your password to begin:"
sudo -v

echo "Executing minikube delete"
minikube delete || exit
echo "Start minikube cluster:"
minikube start --memory=8192 --cpus=7 || exit
echo "Enabling minikube ingress ... "
minikube addons enable ingress || exit
echo "Switching context"
kubectl config use-context minikube