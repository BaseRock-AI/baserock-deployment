# Function to check if a Helm repo already exists
check_repo_exists() {
  helm repo list | grep -w "$1" > /dev/null 2>&1
}

echo "Installing Flink Kubernetes Operator in namespace: ${NAMESPACE}"
echo "CPU Request: $FLINK_OPERATOR_CPU_REQUEST"
echo "Memory Request: $FLINK_OPERATOR_MEM_REQUEST"
echo "CPU Limit: $FLINK_OPERATOR_CPU_LIMIT"
echo "Memory Limit: $FLINK_OPERATOR_MEM_LIMIT"
echo "INTERNET_ACCESS: $INTERNET_ACCESS"

if [[ "$INTERNET_ACCESS" == "Yes" ]]; then
  echo "🚀 Deploying flink with default Bitnami image..."
  if check_repo_exists "flink-operator-repo"; then
    helm repo remove flink-operator-repo
  fi
  if ! check_repo_exists "flink-operator-repo"; then
    helm repo add flink-operator-repo https://archive.apache.org/dist/flink/flink-kubernetes-operator-1.7.0/
  else
    echo "Helm repo 'flink-operator-repo' already exists."
  fi

  helm install flink-kubernetes-operator flink-operator-repo/flink-kubernetes-operator -n "${NAMESPACE}" \
        --set resources.requests.cpu="$FLINK_OPERATOR_CPU_REQUEST" \
        --set resources.requests.memory="$FLINK_OPERATOR_MEM_REQUEST" \
        --set resources.limits.cpu="$FLINK_OPERATOR_CPU_LIMIT" \
        --set resources.limits.memory="$FLINK_OPERATOR_MEM_LIMIT" \
        --timeout 10m

else
  echo "🚀 Deploying flink with custom image: $POSTGRES_IMAGE"
  FLINK_OPERATOR_IMAGE_REPO=$(echo "$FLINK_OPERATOR_IMAGE" | cut -d: -f1)
  FLINK_OPERATOR_IMAGE_TAG=$(echo "$FLINK_OPERATOR_IMAGE" | cut -d: -f2)
  echo "Image Repository: $FLINK_OPERATOR_IMAGE_REPO"
  echo "Image Tag: $FLINK_OPERATOR_IMAGE_TAG"

  helm install flink-kubernetes-operator ./flink-kubernetes-operator -n "${NAMESPACE}" \
        --set resources.requests.cpu="$FLINK_OPERATOR_CPU_REQUEST" \
        --set resources.requests.memory="$FLINK_OPERATOR_MEM_REQUEST" \
        --set resources.limits.cpu="$FLINK_OPERATOR_CPU_LIMIT" \
        --set resources.limits.memory="$FLINK_OPERATOR_MEM_LIMIT" \
        --set image.repository="$FLINK_OPERATOR_IMAGE_REPO" \
        --set image.tag="$FLINK_OPERATOR_IMAGE_TAG" \
        --timeout 10m
fi