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
chmod +x commons/namespace-cleanup.sh
chmod +x integration-testing/initial/flink-operator-uninstall.sh
chmod +x commons/ingress/ingress-cleanup.sh

./commons/aws/set-cluster-context.sh
./integration-testing/initial/flink-operator-uninstall.sh
./commons/cert-manager/cert-manager-cleanup.sh
./commons/ingress/ingress-cleanup.sh
./commons/namespace-cleanup.sh
