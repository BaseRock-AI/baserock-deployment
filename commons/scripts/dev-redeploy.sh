#!/bin/bash

# Prompt for sudo password at the start
echo "Enter your password to begin:"
sudo -v

chmod +x commons/vars/dev-gcp.sh
source ./commons/vars/dev-gcp.sh
chmod +x commons/vars/common-vars.sh
source commons/vars/common-vars.sh

chmod +x commons/scripts/gcp-backend-deploy.sh
chmod +x integration-testing/commons/workflow.sh
chmod +x admin-portal/deploy.sh
chmod +x commons/gcp/set-cluster-context.sh
chmod +x sample-services/todo-service/todo-web-app/deployment.sh
chmod +x sample-services/todo-service/todo-web-service/deployment.sh

./commons/gcp/set-cluster-context.sh
./commons/scripts/gcp-backend-deploy.sh
./integration-testing/commons/workflow.sh
./admin-portal/deploy.sh
./sample-services/todo-service/todo-web-app/deployment.sh
./sample-services/todo-service/todo-web-service/deployment.sh
