source ./commons/messaging.sh


wait_for_dns() {
  DOMAIN=$1
  print_status "Waiting for DNS to resolve for $DOMAIN..."
  for i in {1..30}; do
    if dig +short "$DOMAIN" >/dev/null; then
      echo "✅ DNS resolved: $DOMAIN"
      return
    fi
    sleep 2
  done
  echo "❌ DNS not resolving for $DOMAIN"
  exit 1
}

#print_status "kubectl apply -f commons/cert-manager/secret.yaml -n baserock-backend"
#envsubst < commons/cert-manager/secret.yaml | kubectl apply -n "${NAMESPACE}" -f -
##kubectl apply -f cert-manager/secret.yaml -n "${NAMESPACE}"

print_status "kubectl apply -f commons/cert-manager/issuer.yaml -n baserock-backend"
envsubst < commons/cert-manager/issuer.yaml | kubectl apply -n "${NAMESPACE}" -f -

wait_for_dns "${DOMAIN}"

envsubst < integration-testing/charts/cert-ingress.yaml | kubectl apply -n "${INGRESS_NAMESPACE}" -f -

print_status "kubectl apply -f commons/cert-manager/cert.yaml -n baserock-backend"
envsubst < commons/cert-manager/cert.yaml | kubectl apply -n "${NAMESPACE}" -f -

print_status "Cert manager deployment completed!"
