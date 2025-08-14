INCLUDE_SECRETS="flink-job-secret learning-engine-secret mongodb-secret postgres-secret rabbitmq-secret python-secret"
# Get all secrets in the api-guard namespace and delete the ones in the include list
kubectl get secrets -n "${NAMESPACE}" --no-headers -o custom-columns=":metadata.name" | \
while read secret; do
  if [[ $INCLUDE_SECRETS =~ (^|[[:space:]])$secret($|[[:space:]]) ]]; then
    echo "Deleting secret: $secret"
    kubectl delete secret "$secret" -n "${NAMESPACE}"
  fi
done