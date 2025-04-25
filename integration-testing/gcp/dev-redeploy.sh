#!/bin/bash

# Prompt for sudo password at the start
echo "Enter your password to begin:"
sudo -v

source ./gcp/dev-gcp-vars.sh

chmod +x gcp/install.sh
chmod +x commons/workflow.sh
chmod +x initial/cert-manager-deploy.sh
chmod +x gcp/ingress.sh

./gcp/install.sh
./initial/cert-manager-deploy.sh
./gcp/ingress.sh
./commons/workflow.sh