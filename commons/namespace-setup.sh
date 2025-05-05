source ./commons/messaging.sh
print_status "Creating namespace: ${NAMESPACE}"
kubectl create namespace "${NAMESPACE}" || true
kubectl create namespace ingress-nginx
