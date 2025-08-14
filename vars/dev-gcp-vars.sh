# -- gke --#
export BUCKET_NAME="gs://docker-images-baserock-server"
export GKE_CLUSTER="dev-on-prem"
export GKE_REGION="us-central1"
export PROJECT_ID="development-375212"
export DOMAIN="app.dev.onprem.baserock.ai"
export DOMAIN_PORT=""
export STATIC_IP_ADDRESS="34.45.23.246"
export CERTIFICATE_NAME="app-baserock-onprem-ssl-cert"
export IMAGE_PULL_SECRET=""
export IMAGE_PULL_SECRET_SERVER="https://gcr.io"
export IMAGE_PULL_USERNAME="_json_key"
export IMAGE_PULL_PASSWORD="$(cat commons/aws/key.json)"
export IMAGE_PULL_EMAIL="lumber-image-puller@production-385606.iam.gserviceaccount.com"

#-- config --#
export LLM_API_KEY="<Anthropic-key>"
export VOYAGE_API_KEY="<Voyage-key>"
export GITHUB_APP_ID="<GITHUB-APP-DETAILS>"
export BASEROCK_EMAIL_SMTP="onprem@baserock.ai"
export BASEROCK_EMAIL_PASSWORD_SMTP="ootejotartwhagaw"

#-optional-#
export GITHUB_APP_ID_INT="<>"
export GITHUB_CLIENT_ID="<>"
export GITHUB_CLIENT_SECRET="<>"
export GITHUB_PRIVATE_KEY="<>"

export BITBUCKET_CLIENT_ID="<>"
export BITBUCKET_CLIENT_SECRET="<>"
export BITBUCKET_INSTALLATION_URL="<>"

# -- images --#
export CLIENT_IMAGE="gcr.io/production-385606/client:0.94.1-release-07-30-2025.0"
export UPCASTER_IMAGE="gcr.io/production-385606/upcaster:0.350.1-release-07-30-2025.1"
export FLINK_IMAGE="gcr.io/production-385606/flinkjob-rabbitmq-aggregation:0.58.21-release-07-23-2025.0"
export DJANGO_IMAGE="gcr.io/production-385606/le-django-server:0.350.1-release-07-30-2025.2"
export LE_SERVICE_IMAGE="gcr.io/production-385606/baserock-backend/learning-engine-service:0.217.1-release-07-30-2025.0"
export ADMIN_PORTAL_IMAGE="gcr.io/production-385606/admin-portal-ui:0.15.0"
export TODO_WEB_APP_IMAGE="gcr.io/production-385606/todo-web-app:0.0.1"
export TODO_WEB_SERVICE_IMAGE="gcr.io/production-385606/todo-web-service:0.0.1"
export BACKEND_IMAGE="gcr.io/production-385606/sapient-backend/facade-service"
export BACKEND_TAG="1.215.0"
export CELERY_WORKER_IMAGE="gcr.io/production-385606/celery-worker:0.350.1-release-07-30-2025.0"


#-- backend-extras--#
export VALUES_YAML="backend/baserock-backend/values-gcp.yaml"

#-- todo-web-service --#
export TODO_WEB_SERVICE_SPRING_PROFILES_ACTIVE="dev"

kubectl delete secret "${IMAGE_PULL_SECRET}" -n "${NAMESPACE}"

kubectl create secret docker-registry "${IMAGE_PULL_SECRET}" \
  --docker-server=${IMAGE_PULL_SECRET_SERVER} \
  --docker-username=${IMAGE_PULL_USERNAME} \
  --docker-password=${IMAGE_PULL_PASSWORD} \
  --docker-email=${IMAGE_PULL_EMAIL} \
  -n ${NAMESPACE}
