source ./commons/messaging.sh


print_status "helm jetstack repo update"
helm repo add jetstack https://charts.jetstack.io
helm repo update

echo "check if cert-manager exists"
# Check if cert-manager is already installed
if ! helm status cert-manager -n "${CERT_MANAGER_NAMESPACE}" > /dev/null 2>&1; then
  echo "CERT-MANAGER deployment"
  helm install \
    cert-manager jetstack/cert-manager \
    -n "${CERT_MANAGER_NAMESPACE}" \
    --create-namespace \
    --version 1.15.3 \
    --set global.leaderElection.namespace="${CERT_MANAGER_NAMESPACE}" \
    --set crds.enabled=true
else
  echo "cert-manager is already installed in namespace ${CERT_MANAGER_NAMESPACE}."
fi


print_status "kubectl get pods -n cert-manager"
kubectl get pods -n "${CERT_MANAGER_NAMESPACE}"

# Wait for PostgreSQL to be ready
print_status "Waiting for cert-manager to be ready..."
kubectl wait --namespace "${CERT_MANAGER_NAMESPACE}" \
    --for=condition=Ready pod \
    -l app.kubernetes.io/name=cert-manager \
    --timeout=300s

#kubectl apply -f https://github.com/cert-manager/cert-manager/releases/download/v1.15.3/cert-manager.crds.yaml




