chmod +x commons/cert-manager/cert-manager-cleanup.sh
chmod +x commons/aws/set-cluster-context.sh
chmod +x commons/namespace-cleanup.sh
chmod +x integration-testing/initial/flink-operator-uninstall.sh
chmod +x commons/ingress/ingress-cleanup.sh

./integration-testing/initial/flink-operator-uninstall.sh
./commons/cert-manager/cert-manager-cleanup.sh
./commons/ingress/ingress-cleanup.sh
./commons/namespace-cleanup.sh
