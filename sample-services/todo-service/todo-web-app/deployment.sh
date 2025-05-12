
envsubst < sample-services/todo-service/todo-web-app/deployment.yaml | kubectl apply -n "${NAMESPACE}" -f -
