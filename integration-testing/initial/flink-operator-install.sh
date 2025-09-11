# Function to check if a Helm repo already exists
check_repo_exists() {
  helm repo list | grep -w "$1" > /dev/null 2>&1
}


echo "check_repo_exists flink-operator-repo"
if check_repo_exists "flink-operator-repo"; then
  helm repo remove flink-operator-repo
fi

echo "helm repo add flink-operator-repo "
# Add the Flink operator repo only if it doesn't exist
if ! check_repo_exists "flink-operator-repo"; then
  helm repo add flink-operator-repo https://archive.apache.org/dist/flink/flink-kubernetes-operator-1.7.0/
else
  echo "Helm repo 'flink-operator-repo' already exists."
fi


# Check if the flink-kubernetes-operator is already installed
if ! helm status flink-kubernetes-operator -n "${NAMESPACE}" > /dev/null 2>&1; then
    echo "flink-kubernetes-operator deployment"
    echo "namespace : $NAMESPACE"
    helm install flink-kubernetes-operator flink-operator-repo/flink-kubernetes-operator -n "${NAMESPACE}" \
      --set resources.requests.cpu="$FLINK_OPERATOR_CPU_REQUEST" \
      --set resources.requests.memory="$FLINK_OPERATOR_MEM_REQUEST" \
      --set resources.limits.cpu="$FLINK_OPERATOR_CPU_LIMIT" \
      --set resources.limits.memory="$FLINK_OPERATOR_MEM_LIMIT"
else
  echo "flink-kubernetes-operator is already installed in namespace ${NAMESPACE}."
fi

if [ -z "$FLINK_OPERATOR_IMAGE" ]; then
  echo "🚀 Deploying PostgreSQL with default Bitnami image..."
  helm install flink-kubernetes-operator ./flink-kubernetes-operator -n "${NAMESPACE}" \
        --set resources.requests.cpu="$FLINK_OPERATOR_CPU_REQUEST" \
        --set resources.requests.memory="$FLINK_OPERATOR_MEM_REQUEST" \
        --set resources.limits.cpu="$FLINK_OPERATOR_CPU_LIMIT" \
        --set resources.limits.memory="$FLINK_OPERATOR_MEM_LIMIT" \
        --timeout 10m

else
  echo "🚀 Deploying PostgreSQL with custom image: $POSTGRES_IMAGE"
  FLINK_OPERATOR_IMAGE_REPO=$(echo "$FLINK_OPERATOR_IMAGE" | cut -d: -f1)
  FLINK_OPERATOR_IMAGE_TAG=$(echo "$FLINK_OPERATOR_IMAGE" | cut -d: -f2)

  helm install flink-kubernetes-operator ./flink-kubernetes-operator -n "${NAMESPACE}" \
        --set resources.requests.cpu="$FLINK_OPERATOR_CPU_REQUEST" \
        --set resources.requests.memory="$FLINK_OPERATOR_MEM_REQUEST" \
        --set resources.limits.cpu="$FLINK_OPERATOR_CPU_LIMIT" \
        --set resources.limits.memory="$FLINK_OPERATOR_MEM_LIMIT" \
        --set image.repository="$FLINK_OPERATOR_IMAGE_REPO" \
        --set image.tag="$FLINK_OPERATOR_IMAGE_TAG" \
        --timeout 10m
fi