#!/bin/bash

# Prompt for sudo password at the start
echo "Enter your password to begin:"
sudo -v

chmod +x commons/vars/aws-vars.sh
source ./commons/vars/aws-vars.sh
chmod +x commons/vars/common-vars.sh
source commons/vars/common-vars.sh

chmod +x commons/aws/set-cluster-context.sh
chmod +x commons/scripts/aws-backend-deploy.sh
chmod +x integration-testing/commons/workflow.sh
chmod +x admin-portal/deploy.sh

./commons/aws/set-cluster-context.sh
./integration-testing/commons/workflow.sh
./commons/scripts/aws-backend-deploy.sh
./admin-portal/deploy.sh
./sample-services/todo-service/todo-web-app/deployment.sh
