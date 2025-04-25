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
  helm install flink-kubernetes-operator flink-operator-repo/flink-kubernetes-operator -n "${NAMESPACE}"
else
  echo "flink-kubernetes-operator is already installed in namespace ${NAMESPACE}."
fi