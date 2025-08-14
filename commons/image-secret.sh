#kubectl delete secret "${IMAGE_PULL_SECRET}" -n "${NAMESPACE}"
#
#kubectl create secret docker-registry "${IMAGE_PULL_SECRET}" \
#  --docker-server=${IMAGE_PULL_SECRET_SERVER} \
#  --docker-username=${IMAGE_PULL_USERNAME} \
#  --docker-password=${IMAGE_PULL_PASSWORD} \
#  --docker-email=${IMAGE_PULL_EMAIL} \
#  -n ${NAMESPACE}