source ./commons/messaging.sh
print_status "Creating namespace: ${NAMESPACE}"
kubectl create namespace "${NAMESPACE}" || true

if [[ "$INGRESS_INSTALL_TYPE" == "Yes" ]]; then
  kubectl create namespace ingress-nginx
fi