source ./commons/messaging.sh

print_status "delete cert manager"
helm uninstall cert-manager -n "${CERT_MANAGER_NAMESPACE}"
kubectl delete namespace "${CERT_MANAGER_NAMESPACE}"

print_status "helm jetstack repo update"
helm repo add jetstack https://charts.jetstack.io
helm repo update

print_status "install cert-manager"
helm install cert-manager jetstack/cert-manager \
  --namespace "${CERT_MANAGER_NAMESPACE}" \
  --create-namespace \
  --set installCRDs=true \
  --version 1.8.2 --set global.leaderElection.namespace="${CERT_MANAGER_NAMESPACE}"


print_status "kubectl get pods -n cert-manager"
kubectl get pods -n "${CERT_MANAGER_NAMESPACE}"

# Wait for PostgreSQL to be ready
print_status "Waiting for cert-manager to be ready..."
kubectl wait --namespace "${CERT_MANAGER_NAMESPACE}" \
    --for=condition=Ready pod \
    -l app.kubernetes.io/name=cert-manager \
    --timeout=300s

print_status "kubectl apply -f cert-manager/issuer.yaml -n baserock-backend"
envsubst < cert-manager/issuer.yaml | kubectl apply -n "${NAMESPACE}" -f -

print_status "kubectl apply -f cert-manager/secret.yaml -n baserock-backend"
envsubst < cert-manager/secret.yaml | kubectl apply -n "${NAMESPACE}" -f -
#kubectl apply -f cert-manager/secret.yaml -n "${NAMESPACE}"

print_status "kubectl apply -f cert-manager/cert.yaml -n baserock-backend"
envsubst < cert-manager/cert.yaml | kubectl apply -n "${NAMESPACE}" -f -

print_status "Cert manager deployment completed!"


