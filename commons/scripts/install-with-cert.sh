chmod +x commons/cert-manager/cert-manager-cleanup.sh
chmod +x commons/scripts/install-without-cert.sh
chmod +x ingress_rules/apply-ingress-rules.sh
./commons/cert-manager/cert-manager-deploy.sh
./commons/scripts/install-without-cert.sh

if [[ "$CERTIFICATE_OPTION_TYPE" == "Yes" ]]; then
  chmod +x commons/cert-manager/cert-ingress.sh
  ./commons/cert-manager/cert-ingress.sh
fi

./ingress_rules/apply-ingress-rules.sh
