source ./commons/messaging.sh



echo "
    CERT_MANAGER_NAMESPACE=${CERT_MANAGER_NAMESPACE}
    CERT_MANAGER_VERSION=${CERT_MANAGER_VERSION}
    CERT_CPU_REQUEST=${CERT_CPU_REQUEST}
    CERT_MEM_REQUEST=${CERT_MEM_REQUEST}
    CERT_CPU_LIMIT=${CERT_CPU_LIMIT}
    CERT_MEM_LIMIT=${CERT_MEM_LIMIT}
    CERT_MANAGER_CONTROLLER_IMAGE=${CERT_MANAGER_CONTROLLER_IMAGE}
    CERT_MANAGER_WEBHOOK_IMAGE=${CERT_MANAGER_WEBHOOK_IMAGE}
    CERT_MANAGER_CAINJECTOR_IMAGE=${CERT_MANAGER_CAINJECTOR_IMAGE}
    CERT_MANAGER_ACMESOLVER_IMAGE=${CERT_MANAGER_ACMESOLVER_IMAGE}
    CERT_MANAGER_STARTUPIPCHECK_IMAGE=${CERT_MANAGER_STARTUPIPCHECK_IMAGE}
    "
echo "check if cert-manager exists"
# Check if cert-manager is already installed
if ! helm status cert-manager -n "${CERT_MANAGER_NAMESPACE}" > /dev/null 2>&1; then
  echo "CERT-MANAGER deployment"
  echo "INTERNET_ACCESS: $INTERNET_ACCESS"
  if [[ "$INTERNET_ACCESS" == "Yes" ]]; then
    print_status "helm jetstack repo update"
    helm repo add jetstack https://charts.jetstack.io
    helm repo update
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
    helm install \
      cert-manager ./cert-manager \
      -n "${CERT_MANAGER_NAMESPACE}" \
      --create-namespace \
      --version "${CERT_MANAGER_VERSION}" \
      --set global.leaderElection.namespace="${CERT_MANAGER_NAMESPACE}" \
      --set installCRDs=true \
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
      --set controller.resources.limits.memory="${CERT_MEM_LIMIT}" \
      --set image.repository="${CERT_MANAGER_CONTROLLER_IMAGE}" \
      --set image.tag="${CERT_MANAGER_VERSION}" \
      --set webhook.image.repository="${CERT_MANAGER_WEBHOOK_IMAGE}" \
      --set webhook.image.tag="373e3acd7b96c87a574f9234bb4fbfd576e3205c502d6da5dade41165c9dc828" \
      --set cainjector.image.repository="${CERT_MANAGER_CAINJECTOR_IMAGE}" \
      --set cainjector.image.tag="${CERT_MANAGER_VERSION}" \
      --set startupapicheck.image.repository="${CERT_MANAGER_STARTUPIPCHECK_IMAGE}" \
      --set startupapicheck.image.tag="${CERT_MANAGER_VERSION}" \
      --set acmesolver.image.repository="${CERT_MANAGER_ACMESOLVER_IMAGE}" \
      --set acmesolver.image.tag="${CERT_MANAGER_VERSION}"
  fi
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
if [[ "$CERTIFICATE_OPTION_TYPE" == "Yes" ]]; then
  print_status "kubectl apply -f commons/cert-manager/secret.yaml -n baserock-backend"
  envsubst < commons/cert-manager/secret.yaml | kubectl apply -f -
  #kubectl apply -f cert-manager/secret.yaml -n "${NAMESPACE}"

  print_status "kubectl apply -f commons/cert-manager/issuer.yaml -n baserock-backend"
  envsubst < commons/cert-manager/issuer.yaml | kubectl apply -f -
fi

print_status "Cert manager deployment completed!"


