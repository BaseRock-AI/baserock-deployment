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