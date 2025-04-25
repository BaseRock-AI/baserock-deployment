#!/bin/bash

# Prompt for sudo password at the start
echo "Enter your password to begin:"
sudo -v


chmod +x minikube/install.sh
chmod +x initial/install.sh
chmod +x commons/workflow.sh
chmod +x minikube/tunnel.sh

./commons/workflow.sh
./minikube/tunnel.sh