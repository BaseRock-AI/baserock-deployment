# -- gke --#
export BUCKET_NAME="gs://docker-images-baserock-server"
export GKE_CLUSTER="dev-on-prem"
export GKE_REGION="us-central1"
export PROJECT_ID="development-375212"
export DOMAIN="app.dev.onprem.baserock.ai"
export STATIC_IP_ADDRESS="34.45.23.246"
export CERTIFICATE_NAME="app-baserock-onprem-ssl-cert"
export IMAGE_PULL_SECRET=""

# -- images --#
export CLIENT_IMAGE="gcr.io/production-385606/client-dev-onprem:0.0.1-SM-816-Retest-integration-on-prem-deployment.0"
export UPCASTER_IMAGE="gcr.io/production-385606/upcaster:0.264.0"
export FLINK_IMAGE="gcr.io/production-385606/flinkjob-rabbitmq-aggregation:0.48.0"
export DJANGO_IMAGE="gcr.io/production-385606/le-django-server:0.265.0"
export LE_SERVICE_IMAGE="gcr.io/production-385606/baserock-backend/learning-engine-service:0.163.0"
export ADMIN_PORTAL_IMAGE="gcr.io/production-385606/admin-portal-ui:0.12.1-SM-697.1"
export TODO_WEB_APP_IMAGE="gcr.io/production-385606/todo-web-app:0.0.1"

#-- backend-extras--#
export VALUES_YAML="-f backend/baserock-backend/values-commons.yaml -f backend/baserock-backend/values-gcp.yaml"

#-- django --#
export ANTHROPIC_API_KEY="<>"
export VOYAGE_API_KEY="<>"
export VOYAGE_MODEL_NAME="voyage-3"

chmod +x commons/vars/common-vars.sh
./commons/vars/common-vars.sh