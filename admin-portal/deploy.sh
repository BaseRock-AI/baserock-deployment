if [[ "$BASEROCK_CLOUD_OPTION_TYPE" == "aws" && "$INGRESS_CLASS" == "alb" ]]; then
    envsubst < admin-portal/aws-deploy.yaml | kubectl apply -n "${NAMESPACE}" -f -
elif [[ "$BASEROCK_CLOUD_OPTION_TYPE" == "aws" && "$INGRESS_CLASS" == "nginx" ]]; then
    envsubst < admin-portal/aws-deploy-nginx.yaml | kubectl apply -n "${NAMESPACE}" -f -
else
  envsubst < admin-portal/deploy.yaml | kubectl apply -n "${NAMESPACE}" -f -
fi