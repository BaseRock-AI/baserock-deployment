source ./commons/messaging.sh

CONTEXT="gke_${PROJECT_ID}_${GKE_REGION}_${GKE_CLUSTER}"
print_status "Switching context"
kubectl config use-context $CONTEXT

echo $IMAGE
echo $TAG
print_status "Deploying application..."
helm upgrade --install $HELM_RELEASE ./backend/baserock-backend $VALUES_YAML \
    --namespace $NAMESPACE \
    --set image.repository=$IMAGE \
    --set image.tag=$TAG \
    --set image.pullPolicy=$IMAGE_PULL_POLICY \
    --set ingress.enabled=true \
    --set config.GITLAB_OAUTH_CALLBACK_URL="${HOST_BASE_URL}/login/oauth/callback?oAuthProviderType=gitlab" \
    --set config.LINKEDIN_OAUTH_CALLBACK_URL="${HOST_BASE_URL}/login/oauth/callback?oAuthProviderType=linkedin" \
    --set config.SERVER_BASE_URL="${SCHEME}://${HOST_BASE_URL}" \
    --set ingress.hosts[0].host="${HOST_BASE_URL}" \
    --set ingress.hosts[0].paths[0].path="/" \
    --set ingress.hosts[0].paths[0].pathType="${INGRESS_PATH_TYPE}" \
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