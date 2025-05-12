envsubst < integration-testing/commons/init.sql | kubectl create configmap postgres-init-scripts-it --from-file=init.sql=/dev/stdin --namespace=${NAMESPACE}
envsubst < integration-testing/charts/rabbitmq.yaml | kubectl apply -n "${NAMESPACE}" -f -
envsubst < integration-testing/charts/postgres.yaml | kubectl apply -n "${NAMESPACE}" -f -
envsubst < integration-testing/charts/mongodb.yaml | kubectl apply -n "${NAMESPACE}" -f -
envsubst < integration-testing/charts/mongodb-client.yaml | kubectl apply -n "${NAMESPACE}" -f -