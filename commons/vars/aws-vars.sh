# -- gke --#
export EKS_CLUSTER="dev-lumberfi-eks-cluster"
export AWS_REGION="us-east-1"
export AWS_ACCOUNT_ID="220604648671"
export DOMAIN="dev-baserock.lumberfi.com"
export STATIC_IP_ADDRESS="3.230.138.184"
export CERTIFICATE_NAME="app-baserock-onprem-ssl-cert"
export IMAGE_PULL_SECRET="gcr-json-key"

# -- images --#
export CLIENT_IMAGE="vikasbaserock/client-dev-onprem:0.0.1-SM-816-Retest-integration-on-prem-deployment.0"
export UPCASTER_IMAGE="vikasbaserock/upcaster:0.264.0"
export FLINK_IMAGE="vikasbaserock/flinkjob-rabbitmq-aggregation:0.48.0"
export DJANGO_IMAGE="vikasbaserock/le-django-server:0.265.0"
export LE_SERVICE_IMAGE="vikasbaserock/baserock-backend/learning-engine-service:0.163.0"
export ADMIN_PORTAL_IMAGE="vikasbaserock/admin-portal-ui:0.12.1-SM-697.1"
export TODO_WEB_APP_IMAGE="vikasbaserock/todo-web-app:0.0.1"
export TODO_WEB_SERVICE_IMAGE="vikasbaserock/todo-web-service:0.0.1"

#-- backend-extras--#
export VALUES_YAML="-f backend/baserock-backend/values-commons.yaml -f backend/baserock-backend/values-gcp.yaml"

#-- django --#
export ANTHROPIC_API_KEY="<>"
export VOYAGE_API_KEY="<>"
export VOYAGE_MODEL_NAME="voyage-3"

#-- todo-web-service --#
export TODO_WEB_SERVICE_SPRING_PROFILES_ACTIVE="prod"

chmod +x commons/vars/common-vars.sh
./commons/vars/common-vars.sh