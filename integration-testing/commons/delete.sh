
# Store the list of deployments to exclude
EXCLUDE_DEPLOYMENTS="baserock-backend-deployment admin-portal-deployment cert-manager cert-manager-cainjector cert-manager-webhook flink-kubernetes-operator"

# Get all deployments in the api-guard namespace and delete the ones not in the exclude list
kubectl get deployments -n "${NAMESPACE}" --no-headers -o custom-columns=":metadata.name" | \
while read deployment; do
  if ! [[ $EXCLUDE_DEPLOYMENTS =~ (^|[[:space:]])$deployment($|[[:space:]]) ]]; then
    echo "Deleting deployment: $deployment"
    kubectl delete deployment "$deployment" -n "${NAMESPACE}"
  fi
done
