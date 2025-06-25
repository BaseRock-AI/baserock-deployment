# -- gke --#
export BUCKET_NAME="gs://docker-images-baserock-server"
export GKE_CLUSTER="dev-on-prem"
export GKE_REGION="us-central1"
export PROJECT_ID="development-375212"
export DOMAIN="app.dev.onprem.baserock.ai"
export DOMAIN_PORT=""
export STATIC_IP_ADDRESS="34.45.23.246"
export CERTIFICATE_NAME="app-baserock-onprem-ssl-cert"
export IMAGE_PULL_SECRET="docker-key"
export IMAGE_PULL_SECRET_SERVER="https://index.docker.io/v1/"
export IMAGE_PULL_USERNAME="vikasbaserock"
export IMAGE_PULL_PASSWORD="dckr_pat_-p-fjCLeIUT07Vv97LxNC6fAFUM"
export IMAGE_PULL_EMAIL="vikas@baserock.ai"


# -- images --#
export CLIENT_IMAGE="vikasbaserock/client:latest"
export UPCASTER_IMAGE="vikasbaserock/upcaster:latest"
export FLINK_IMAGE="vikasbaserock/flinkjob-rabbitmq-aggregation:latest"
export DJANGO_IMAGE="vikasbaserock/le-django-server:latest"
export LE_SERVICE_IMAGE="vikasbaserock/learning-engine-service:latest"
export ADMIN_PORTAL_IMAGE="vikasbaserock/admin-portal-ui:latest"
export TODO_WEB_APP_IMAGE="vikasbaserock/todo-web-app:latest"
export TODO_WEB_SERVICE_IMAGE="vikasbaserock/todo-web-service:latest"
export BACKEND_IMAGE="vikasbaserock/baserock-facade-service:latest"
export CELERY_WORKER_IMAGE="vikasbaserock/celery-worker:latest"


#-- backend-extras--#
export VALUES_YAML="backend/baserock-backend/values-gcp.yaml"

#-- todo-web-service --#
export TODO_WEB_SERVICE_SPRING_PROFILES_ACTIVE="dev"