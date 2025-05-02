
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

INCLUDE_SECRETS="upcaster-secrets flink-job-secret learning-engine-secret mongodb-secret postgres-secret django-service-secret rabbitmq-secret"
# Get all secrets in the api-guard namespace and delete the ones in the include list
kubectl get secrets -n "${NAMESPACE}" --no-headers -o custom-columns=":metadata.name" | \
while read secret; do
  if [[ $INCLUDE_SECRETS =~ (^|[[:space:]])$secret($|[[:space:]]) ]]; then
    echo "Deleting secret: $secret"
    kubectl delete secret "$secret" -n "${NAMESPACE}"
  fi
done