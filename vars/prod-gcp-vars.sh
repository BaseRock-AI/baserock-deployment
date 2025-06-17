# -- gke --#
export BUCKET_NAME="gs://docker-images-baserock-server"
export GKE_CLUSTER="on-prem-cluster"
export GKE_REGION="us-central1"
export PROJECT_ID="production-385606"
export DOMAIN="app.onprem.baserock.ai"
export DOMAIN_PORT=""
export STATIC_IP_ADDRESS="34.122.141.94"
export CERTIFICATE_NAME="app-baserock-onprem-prod-ssl-cert"
export IMAGE_PULL_SECRET=""
export IMAGE_PULL_SECRET_SERVER="https://gcr.io"
export IMAGE_PULL_USERNAME="_json_key"
export IMAGE_PULL_PASSWORD="$(cat commons/aws/key.json)"
export IMAGE_PULL_EMAIL="lumber-image-puller@production-385606.iam.gserviceaccount.com"

# -- images --#
export CLIENT_IMAGE="gcr.io/production-385606/client:0.53.0"
export UPCASTER_IMAGE="gcr.io/production-385606/upcaster:0.270.0"
export FLINK_IMAGE="gcr.io/production-385606/flinkjob-rabbitmq-aggregation:0.48.2-feature-concentric-deployment.1"
export DJANGO_IMAGE="gcr.io/production-385606/le-django-server:0.269.0"
export LE_SERVICE_IMAGE="gcr.io/production-385606/baserock-backend/learning-engine-service:0.164.0"
export ADMIN_PORTAL_IMAGE="gcr.io/production-385606/admin-portal-ui:0.12.1-SM-697.1"
export TODO_WEB_APP_IMAGE="gcr.io/production-385606/todo-web-app:0.0.1"
export TODO_WEB_SERVICE_IMAGE="gcr.io/production-385606/todo-web-service:0.0.1"
export BACKEND_IMAGE="gcr.io/production-385606/sapient-backend/facade-service"
export BACKEND_TAG="1.182.0"
#-- backend-extras--#
export VALUES_YAML="backend/baserock-backend/values-gcp-prod.yaml"

#-- django --#
export ANTHROPIC_API_KEY="<>"
export VOYAGE_API_KEY="<>"
export VOYAGE_MODEL_NAME="voyage-3"

#-- todo-web-service --#
export TODO_WEB_SERVICE_SPRING_PROFILES_ACTIVE="prod"