# -- images --#
export CLIENT_IMAGE="${REPO_NAME}/client:0.104.1-release-08-20-2025.1"
export UPCASTER_IMAGE="${REPO_NAME}/upcaster:0.386.3-release-08-21-2025.3"
export FLINK_IMAGE="${REPO_NAME}/flinkjob-rabbitmq-aggregation:0.58.21-release-07-23-2025.0"
export DJANGO_IMAGE="${REPO_NAME}/le-django-server:0.386.3-release-08-21-2025.4"
export LE_SERVICE_IMAGE="${REPO_NAME}/baserock-backend/learning-engine-service:0.222.1-release-08-20-2025.1"
export ADMIN_PORTAL_IMAGE="${REPO_NAME}/admin-portal-ui:0.15.1-SM-1610-disable-oauth-flag.3"
export TODO_WEB_APP_IMAGE="${REPO_NAME}/todo-web-app:0.0.1"
export TODO_WEB_SERVICE_IMAGE="${REPO_NAME}/todo-web-service:0.0.1"
export BACKEND_IMAGE="${REPO_NAME}/sapient-backend/facade-service"+export BACKEND_TAG="1.220.0"
export CELERY_WORKER_IMAGE="${REPO_NAME}/celery-worker:0.386.3-release-08-21-2025.5"

#-- llm versions--#
export LLM_MODEL_NAME="claude-3-5-sonnet-20241022"
export VOYAGE_MODEL_NAME=voyage-3"