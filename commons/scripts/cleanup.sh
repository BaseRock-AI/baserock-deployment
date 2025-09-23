chmod +x commons/cert-manager/cert-manager-cleanup.sh
chmod +x commons/aws/set-cluster-context.sh
chmod +x commons/namespace-cleanup.sh
chmod +x integration-testing/initial/flink-operator-uninstall.sh
chmod +x commons/ingress/ingress-cleanup.sh

./integration-testing/initial/flink-operator-uninstall.sh

if [[ "$CERT_MANAGER_OPTION_TYPE" == "Yes" ]];then
  ./commons/cert-manager/cert-manager-cleanup.sh
fi

if [[ "$INGRESS_INSTALL_TYPE" == "Yes" ]];then
  ./commons/ingress/ingress-cleanup.sh
fi

./commons/namespace-cleanup.sh
