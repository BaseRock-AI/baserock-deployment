source ./commons/messaging.sh

if [[ "$BASEROCK_CLOUD_OPTION_TYPE" == "gcp" ]]; then
  kubectl delete secret "${IMAGE_PULL_SECRET}" -n "${NAMESPACE}"

  kubectl create secret docker-registry "${IMAGE_PULL_SECRET}" \
    --docker-server="${IMAGE_PULL_SECRET_SERVER}" \
    --docker-username="${IMAGE_PULL_USERNAME}" \
    --docker-password="${IMAGE_PULL_PASSWORD}" \
    --docker-email="${IMAGE_PULL_EMAIL}" \
    -n "${NAMESPACE}"

elif [[ "$BASEROCK_CLOUD_OPTION_TYPE" == "aws" ]]; then
  kubectl delete secret "${IMAGE_PULL_SECRET}" -n "${NAMESPACE}"
  if [ -n "$AWS_ACCESS_KEY_ID" ]; then
    echo "Using manually provided Docker credentials..."
    kubectl create secret docker-registry "${IMAGE_PULL_SECRET}" \
      --docker-server="${IMAGE_PULL_SECRET_SERVER}" \
      --docker-username="${IMAGE_PULL_USERNAME}" \
      --docker-password="${IMAGE_PULL_PASSWORD}" \
      --docker-email="${IMAGE_PULL_EMAIL}" \
      -n "${NAMESPACE}"
  else
    echo "Using AWS ECR credentials..."
    kubectl create secret docker-registry aws-pull-secret \
      --docker-server="${IMAGE_PULL_SECRET_SERVER}" \
      --docker-username="${IMAGE_PULL_USERNAME}" \
      --docker-password="${IMAGE_PULL_PASSWORD}" \
      --docker-email=${IMAGE_PULL_EMAIL} \
      -n "${NAMESPACE}"
  fi
fi