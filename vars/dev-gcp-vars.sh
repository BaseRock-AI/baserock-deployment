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

# -- images --#
export CLIENT_IMAGE="gcr.io/production-385606/client:0.89.1-release-07-23-2025.1"
export UPCASTER_IMAGE="gcr.io/production-385606/upcaster:0.341.3-release-07-22-2025.0"
export FLINK_IMAGE="gcr.io/production-385606/flinkjob-rabbitmq-aggregation:0.58.21-release-07-23-2025.0"
export DJANGO_IMAGE="gcr.io/production-385606/le-django-server:0.341.3-release-07-22-2025.4"
export LE_SERVICE_IMAGE="gcr.io/production-385606/baserock-backend/learning-engine-service:0.214.1-release-07-23-2025.1"
export ADMIN_PORTAL_IMAGE="gcr.io/production-385606/admin-portal-ui:0.15.0"
export TODO_WEB_APP_IMAGE="gcr.io/production-385606/todo-web-app:0.0.1"
export TODO_WEB_SERVICE_IMAGE="gcr.io/production-385606/todo-web-service:0.0.1"
export BACKEND_IMAGE="gcr.io/production-385606/sapient-backend/facade-service"
export BACKEND_TAG="1.212.0"
export CELERY_WORKER_IMAGE="gcr.io/production-385606/celery-worker:0.341.3-release-07-22-2025.1"


#-- backend-extras--#
export VALUES_YAML="backend/baserock-backend/values-gcp.yaml"

#-- todo-web-service --#
export TODO_WEB_SERVICE_SPRING_PROFILES_ACTIVE="dev"