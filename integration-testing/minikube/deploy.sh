#!/bin/bash

# Prompt for sudo password at the start
echo "Enter your password to begin:"
sudo -v

source ./minikube/minikube-vars.sh

chmod +x minikube/install.sh
chmod +x initial/install.sh
chmod +x commons/workflow.sh
chmod +x minikube/tunnel.sh
chmod +x images/images_minikube.sh
chmod +x commons/namespace-setup.sh


./minikube/install.sh
./commons/namespace-setup.sh
./initial/install.sh
./images/images_minikube.sh
./commons/workflow.sh
./minikube/tunnel.sh
