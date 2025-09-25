envsubst < admin-portal/deploy.yaml | kubectl apply -n "${NAMESPACE}" -f -
