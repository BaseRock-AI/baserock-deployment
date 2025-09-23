
envsubst < integration-testing/charts/python-secret.yaml | kubectl apply -n "${NAMESPACE}" -f -
envsubst < integration-testing/charts/python-service.yaml | kubectl apply -n "${NAMESPACE}" -f -
envsubst < integration-testing/charts/learning-engine.yaml | kubectl apply -n "${NAMESPACE}" -f -
envsubst < integration-testing/charts/flink-aggregation-job.yaml | kubectl apply -n "${NAMESPACE}" -f -
envsubst < integration-testing/charts/batch-upcaster.yaml | kubectl apply -n "${NAMESPACE}" -f -
envsubst < integration-testing/charts/client.yaml | kubectl apply -n "${NAMESPACE}" -f -

if [[ "$BASEROCK_CLOUD_OPTION_TYPE" == "aws" && "$INGRESS_CLASS" == "alb"  ]]; then
  envsubst < integration-testing/charts/ingress-aws.yaml | kubectl apply -n "${NAMESPACE}" -f -
elif [[ "$BASEROCK_CLOUD_OPTION_TYPE" == "aws" && "$INGRESS_CLASS" == "nginx"  ]]; then
  envsubst < integration-testing/charts/ingress-aws-nginx.yaml | kubectl apply -n "${NAMESPACE}" -f -
else
  envsubst < integration-testing/charts/ingress.yaml | kubectl apply -n "${NAMESPACE}" -f -
fi

envsubst < integration-testing/charts/celery-worker.yaml | kubectl apply -n "${NAMESPACE}" -f -

