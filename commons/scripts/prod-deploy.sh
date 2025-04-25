#!/bin/bash

# Prompt for sudo password at the start
echo "Enter your password to begin:"
sudo -v

source ./gcp/prod-gcp-vars.sh

chmod +x initial/install.sh
chmod +x initial/cert-manager-deploy.sh
chmod +x gcp/install.sh
chmod +x gcp/ingress.sh
chmod +x commons/workflow.sh
chmod +x commons/namespace-setup.sh

./gcp/install.sh
./commons/namespace-setup.sh
./initial/install.sh
./initial/cert-manager-deploy.sh
./gcp/ingress.sh
./commons/workflow.sh