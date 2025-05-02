chmod +x commons/cert-manager/cert-manager-cleanup.sh
chmod +x commons/scripts/install-without-cert.sh

./commons/cert-manager/cert-manager-deploy.sh
./commons/scripts/install-without-cert.sh
