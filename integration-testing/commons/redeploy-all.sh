#!/bin/bash

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

envsubst < integration-testing/charts/rabbitmq.yaml | kubectl apply -n "${NAMESPACE}" -f -
envsubst < integration-testing/charts/postgres.yaml | kubectl apply -n "${NAMESPACE}" -f -
envsubst < integration-testing/charts/mongodb.yaml | kubectl apply -n "${NAMESPACE}" -f -
envsubst < integration-testing/charts/mongodb-client.yaml | kubectl apply -n "${NAMESPACE}" -f -
envsubst < integration-testing/charts/python-service.yaml | kubectl apply -n "${NAMESPACE}" -f -
envsubst < integration-testing/charts/learning-engine.yaml | kubectl apply -n "${NAMESPACE}" -f -
envsubst < integration-testing/charts/flink-aggregation-job.yaml | kubectl apply -n "${NAMESPACE}" -f -
envsubst < integration-testing/charts/batch-upcaster.yaml | kubectl apply -n "${NAMESPACE}" -f -
envsubst < integration-testing/charts/client.yaml | kubectl apply -n "${NAMESPACE}" -f -





