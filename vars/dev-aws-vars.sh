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
export CLIENT_IMAGE="vikasbaserock/client:0.64.0"
export UPCASTER_IMAGE="vikasbaserock/upcaster:0.303.0"
export FLINK_IMAGE="vikasbaserock/flinkjob-rabbitmq-aggregation:0.55.0"
export DJANGO_IMAGE="vikasbaserock/le-django-server:0.304.0"
export LE_SERVICE_IMAGE="vikasbaserock/learning-engine-service:0.179.1"
export ADMIN_PORTAL_IMAGE="vikasbaserock/admin-portal-ui:0.14.0"
export TODO_WEB_APP_IMAGE="vikasbaserock/todo-web-app:0.0.1"
export TODO_WEB_SERVICE_IMAGE="vikasbaserock/todo-web-service:0.0.1"
export BACKEND_IMAGE="vikasbaserock/baserock-facade-service"
export BACKEND_TAG="1.182.0"
#-- backend-extras--#
export VALUES_YAML="backend/baserock-backend/values-aws-dev.yaml"

#-- django --#
export ANTHROPIC_API_KEY="<>"
export VOYAGE_API_KEY="<>"
export VOYAGE_MODEL_NAME="voyage-3"

#-- todo-web-service --#
export TODO_WEB_SERVICE_SPRING_PROFILES_ACTIVE="dev"