#!/bin/bash

# Prompt for sudo password at the start
echo "Enter your password to begin:"
sudo -v

chmod +x commons/vars/aws-vars.sh
source ./commons/vars/aws-vars.sh
chmod +x commons/vars/common-vars.sh
source commons/vars/common-vars.sh


chmod +x commons/cert-manager/cert-manager-cleanup.sh
chmod +x commons/aws/set-cluster-context.sh
chmod +x commons/namespace-setup.sh
chmod +x commons/cert-manager/cert-manager-deploy.sh
chmod +x integration-testing/initial/flink-operator-install.sh
chmod +x commons/ingress/ingress-deploy.sh
chmod +x commons/scripts/aws-backend-deploy.sh
chmod +x integration-testing/commons/workflow.sh
chmod +x admin-portal/deploy.sh
chmod +x integration-testing/initial/flink-operator-uninstall.sh
chmod +x commons/aws/secret.sh

./commons/aws/set-cluster-context.sh
./integration-testing/initial/flink-operator-uninstall.sh
./commons/cert-manager/cert-manager-cleanup.sh
./commons/namespace-setup.sh
./commons/aws/secret.sh
./commons/cert-manager/cert-manager-deploy.sh
./integration-testing/initial/flink-operator-install.sh
./commons/ingress/ingress-deploy.sh
./integration-testing/commons/workflow.sh
./commons/scripts/aws-backend-deploy.sh
./admin-portal/deploy.sh
./sample-services/todo-service/todo-web-app/deployment.sh
