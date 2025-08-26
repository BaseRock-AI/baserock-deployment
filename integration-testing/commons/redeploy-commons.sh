envsubst < integration-testing/charts/rabbitmq.yaml | kubectl apply -n "${NAMESPACE}" -f -
envsubst < integration-testing/charts/mongodb.yaml | kubectl apply -n "${NAMESPACE}" -f -
