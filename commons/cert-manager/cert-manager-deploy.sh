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
    --version "${CERT_MANAGER_VERSION}" \
    --set global.leaderElection.namespace="${CERT_MANAGER_NAMESPACE}" \
    --set crds.enabled=true \
    --set webhook.resources.requests.cpu="${CERT_CPU_REQUEST}" \
    --set webhook.resources.requests.memory="${CERT_MEM_REQUEST}" \
    --set webhook.resources.limits.cpu="${CERT_CPU_LIMIT}" \
    --set webhook.resources.limits.memory="${CERT_MEM_LIMIT}" \
    --set cainjector.resources.requests.cpu="${CERT_CPU_REQUEST}" \
    --set cainjector.resources.requests.memory="${CERT_MEM_REQUEST}" \
    --set cainjector.resources.limits.cpu="${CERT_CPU_LIMIT}" \
    --set cainjector.resources.limits.memory="${CERT_MEM_LIMIT}" \
    --set controller.resources.requests.cpu="${CERT_CPU_REQUEST}" \
    --set controller.resources.requests.memory="${CERT_MEM_REQUEST}" \
    --set controller.resources.limits.cpu="${CERT_CPU_LIMIT}" \
    --set controller.resources.limits.memory="${CERT_MEM_LIMIT}"
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

print_status "kubectl apply -f commons/cert-manager/secret.yaml -n baserock-backend"
envsubst < commons/cert-manager/secret.yaml | kubectl apply -f -
#kubectl apply -f cert-manager/secret.yaml -n "${NAMESPACE}"

print_status "kubectl apply -f commons/cert-manager/issuer.yaml -n baserock-backend"
envsubst < commons/cert-manager/issuer.yaml | kubectl apply -f -

#
#print_status "kubectl apply -f commons/cert-manager/cert.yaml -n baserock-backend"
#envsubst < commons/cert-manager/cert.yaml | kubectl apply -f -

print_status "Cert manager deployment completed!"


