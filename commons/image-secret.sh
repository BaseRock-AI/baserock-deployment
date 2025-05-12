kubectl delete secret "${IMAGE_PULL_SECRET}" -n "${NAMESPACE}"

kubectl create secret docker-registry "${IMAGE_PULL_SECRET}" \
  --docker-server=${IMAGE_PULL_SECRET_SERVER} \
  --docker-username=_json_key \
  --docker-password="$(cat commons/aws/key.json)" \
  --docker-email="lumber-image-puller@production-385606.iam.gserviceaccount.com" \
  -n ${NAMESPACE}