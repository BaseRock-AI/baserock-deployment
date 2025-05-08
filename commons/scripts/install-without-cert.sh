chmod +x commons/cert-manager/certificate-deploy.sh
chmod +x integration-testing/initial/flink-operator-install.sh
chmod +x commons/ingress/ingress-deploy.sh


./integration-testing/initial/flink-operator-install.sh
./commons/ingress/ingress-deploy.sh
./commons/cert-manager/certificate-deploy.sh
