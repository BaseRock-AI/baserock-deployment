#!/bin/bash

# Prompt for sudo password at the start
echo "Enter your password to begin:"
sudo -v

chmod +x commons/vars/prod-gcp.sh
source ./commons/vars/prod-gcp.sh

chmod +x commons/scripts/gcp-backend-deploy.sh
chmod +x integration-testing/commons/workflow.sh
chmod +x admin-portal/deploy.sh

./commons/scripts/gcp-backend-deploy.sh
./integration-testing/commons/workflow.sh
./admin-portal/deploy.sh