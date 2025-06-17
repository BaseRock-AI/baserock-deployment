source ./commons/messaging.sh

print_status "Deploying application..."
helm upgrade --install "${HELM_RELEASE}" ./backend/baserock-backend \
    -f backend/baserock-backend/values-commons.yaml \
    -f "${VALUES_YAML}" \
    --namespace "${NAMESPACE}" \
    --set image.repository="${BACKEND_IMAGE}" \
    --set image.tag="${BACKEND_TAG}" \
    --set image.pullPolicy="${BACKEND_PULL_POLICY}" \
    --set ingress.enabled=true \
    --set ingress.tls[0].hosts[0]="${DOMAIN}" \
    --set ingress.tls[0].secretName="${CERTIFICATE_NAME}" \
    --set config.GITLAB_OAUTH_CALLBACK_URL="${DOMAIN}${DOMAIN_PORT}/login/oauth/callback?oAuthProviderType=gitlab" \
    --set config.LINKEDIN_OAUTH_CALLBACK_URL="${DOMAIN}${DOMAIN_PORT}/login/oauth/callback?oAuthProviderType=linkedin" \
    --set config.SERVER_BASE_URL="${SCHEME}://${DOMAIN}${DOMAIN_PORT}" \
    --set ingress.hosts[0].host="${DOMAIN}" \
    --set ingress.hosts[0].paths[0].path="/" \
    --set ingress.hosts[0].paths[0].pathType="${INGRESS_PATH_TYPE}" \
    --set secrets.baserockBackend.BASEROCK_EMAIL="${BASEROCK_EMAIL_SMTP}" \
    --set secrets.baserockBackend.BASEROCK_EMAIL_PASSWORD="${BASEROCK_EMAIL_PASSWORD_SMTP}" \
    --set imagePullSecrets[0].name="${IMAGE_PULL_SECRET}" \
    --set resources.limits.cpu="${BACKEND_CPUS}" \
    --set resources.limits.memory="${BACKEND_MEMORY}" \
    --set resources.requests.cpu="${BACKEND_CPUS_REQUESTS}" \
    --set resources.requests.memory="${BACKEND_MEMORY_REQUESTS}" \
    --set postgres.enabled="${BACKEND_POSTGRES_ENABLED}" \
    --set postgres.auth.username="${POSTGRES_USERNAME}" \
    --set postgres.auth.password="${POSTGRES_DB_PASSWORD}" \
    --set postgres.auth.database="${POSTGRES_DB_NAME}" \
    --set postgres.primary.persistence.enabled="${BACKEND_POSTGRES_ENABLED}" \
    --set postgres.primary.persistence.size="${BACKEND_POSTGRES_PERSISTENCE_SIZE}" \
    --set redis.enabled="${BACKEND_REDIS_ENABLED}" \
    --set redis.architecture="${BACKEND_REDIS_ARCHITECTURE}" \
    --set redis.auth.enabled="${BACKEND_REDIS_AUTH_ENABLED}" \
    --set redis.auth.password="${BACKEND_REDIS_AUTH_PASSWORD}" \
    --set redis.master.persistence.enabled="${BACKEND_REDIS_ENABLED}" \
    --set redis.master.persistence.size="${BACKEND_REDIS_PERSISTENCE_SIZE}" \
    --set secrets.baserockBackend.REDIS_PASSWORD="${BACKEND_REDIS_AUTH_PASSWORD}" \
    --set config.TARGET_DB_NAME="${POSTGRES_DB_NAME}" \
    --set service.type="${BACKEND_SERVICE_TYPE}" \
    --set service.port="${BACKEND_SERVICE_PORT}" \
    --set service.targetPort="${BACKEND_SERVICE_TARGET_PORT}" \
    --set replicaCount="${BACKEND_REPLICA_COUNT}" \
    --timeout 10m


# Check deployment status
if [ $? -eq 0 ]; then
    print_status "Deployment successful! Checking pod status..."
    kubectl get pods -n $NAMESPACE
else
    print_error "Failed to deploy Helm chart"
    print_status "Checking logs..."
    kubectl get pods -n $NAMESPACE
    exit 1
fi