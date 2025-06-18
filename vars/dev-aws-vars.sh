# -- gke --#
export EKS_CLUSTER="<>"
export AWS_REGION="<>"
export AWS_ACCOUNT_ID="<>"
export DOMAIN="<>"
export DOMAIN_PORT=""
export STATIC_IP_ADDRESS="<>"
export CERTIFICATE_NAME="<>"
export IMAGE_PULL_SECRET="<>"
export IMAGE_PULL_SECRET_SERVER="<>"
export IMAGE_PULL_USERNAME="<>"
export IMAGE_PULL_PASSWORD="<>"
export IMAGE_PULL_EMAIL="<>"

# -- images --#
export CLIENT_IMAGE="vikasbaserock/client:latest"
export UPCASTER_IMAGE="vikasbaserock/upcaster:latest"
export FLINK_IMAGE="vikasbaserock/flinkjob-rabbitmq-aggregation:latest"
export DJANGO_IMAGE="vikasbaserock/le-django-server:latest"
export LE_SERVICE_IMAGE="vikasbaserock/learning-engine-service:latest"
export ADMIN_PORTAL_IMAGE="vikasbaserock/admin-portal-ui:latest"
export TODO_WEB_APP_IMAGE="vikasbaserock/todo-web-app:latest"
export TODO_WEB_SERVICE_IMAGE="vikasbaserock/todo-web-service:latest"
export BACKEND_IMAGE="vikasbaserock/baserock-facade-service"
export BACKEND_TAG="latest"
export CELERY_WORKER_IMAGE="vikas-baserock/celery-worker:latest"

#-- backend-extras--#
export VALUES_YAML="backend/baserock-backend/values-aws-dev.yaml"

#-- todo-web-service --#
export TODO_WEB_SERVICE_SPRING_PROFILES_ACTIVE="dev"