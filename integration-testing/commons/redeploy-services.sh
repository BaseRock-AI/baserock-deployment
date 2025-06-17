envsubst < integration-testing/charts/python-service.yaml | kubectl apply -n "${NAMESPACE}" -f -
envsubst < integration-testing/charts/learning-engine.yaml | kubectl apply -n "${NAMESPACE}" -f -
envsubst < integration-testing/charts/flink-aggregation-job.yaml | kubectl apply -n "${NAMESPACE}" -f -
envsubst < integration-testing/charts/batch-upcaster.yaml | kubectl apply -n "${NAMESPACE}" -f -
envsubst < integration-testing/charts/client.yaml | kubectl apply -n "${NAMESPACE}" -f -
envsubst < integration-testing/charts/ingress.yaml | kubectl apply -n "${NAMESPACE}" -f -
envsubst < integration-testing/charts/celery-worker.yaml | kubectl apply -n "${NAMESPACE}" -f -

