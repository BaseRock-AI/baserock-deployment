# -- gke --#
export EKS_CLUSTER="<>"
export AWS_REGION="<>"
export AWS_ACCOUNT_ID="<>"
export DOMAIN="<>"
export DOMAIN_PORT=""
export STATIC_IP_ADDRESS="<>"
export CERTIFICATE_NAME="<>"
export AWS_ACCESS_KEY_ID=""
export AWS_SECRET_ACCESS_KEY=""
export AWS_DEFAULT_REGION="${AWS_REGION}"
export IMAGE_PULL_SECRET="aws-pull-secret"
export IMAGE_PULL_SECRET_SERVER="<aws_account_id>.dkr.ecr.<region>.amazonaws.com"
export IMAGE_PULL_USERNAME="AWS"
export IMAGE_PULL_PASSWORD="$(aws ecr get-login-password --region ${AWS_REGION})"
export IMAGE_PULL_EMAIL="<EMAIL>"

#-- config --#
export LLM_API_KEY="<Anthropic-key>"
export VOYAGE_API_KEY="<Voyage-key>"
export BASEROCK_EMAIL_SMTP="onprem@baserock.ai"
export BASEROCK_EMAIL_PASSWORD_SMTP="ootejotartwhagaw"

#-optional-#
export GITHUB_APP_ID="<GITHUB-APP-DETAILS>"
export GITHUB_APP_ID_INT="<>"
export GITHUB_CLIENT_ID="<>"
export GITHUB_CLIENT_SECRET="<>"
export GITHUB_PRIVATE_KEY="<>"

export BITBUCKET_CLIENT_ID="<>"
export BITBUCKET_CLIENT_SECRET="<>"
export BITBUCKET_INSTALLATION_URL="<>"
export BITBUCKET_REDIRECT_URI="<>"


# -- images --#
export AWS_REPO_NAME="<AWS_REPO_NAME>"
export CLIENT_IMAGE="${AWS_REPO_NAME}/client:latest"
export UPCASTER_IMAGE="${AWS_REPO_NAME}/upcaster:latest"
export FLINK_IMAGE="${AWS_REPO_NAME}/flinkjob-rabbitmq-aggregation:latest"
export DJANGO_IMAGE="${AWS_REPO_NAME}/le-django-server:latest"
export LE_SERVICE_IMAGE="${AWS_REPO_NAME}/learning-engine-service:latest"
export ADMIN_PORTAL_IMAGE="${AWS_REPO_NAME}/admin-portal-ui:latest"
export TODO_WEB_APP_IMAGE="${AWS_REPO_NAME}/todo-web-app:latest"
export TODO_WEB_SERVICE_IMAGE="${AWS_REPO_NAME}/todo-web-service:latest"
export BACKEND_IMAGE="${AWS_REPO_NAME}/baserock-facade-service"
export BACKEND_TAG="latest"
export CELERY_WORKER_IMAGE="${AWS_REPO_NAME}/celery-worker:latest"

#-- backend-extras--#
export VALUES_YAML="backend/baserock-backend/values-aws-prod.yaml"

#-- todo-web-service --#
export TODO_WEB_SERVICE_SPRING_PROFILES_ACTIVE="prod"


