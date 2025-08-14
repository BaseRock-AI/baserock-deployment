# -- images --#
export CLIENT_IMAGE="${REPO_NAME}/client:latest"
export UPCASTER_IMAGE="${REPO_NAME}/upcaster:latest"
export FLINK_IMAGE="${REPO_NAME}/flinkjob-rabbitmq-aggregation:latest"
export DJANGO_IMAGE="${REPO_NAME}/le-django-server:latest"
export LE_SERVICE_IMAGE="${REPO_NAME}/learning-engine-service:latest"
export ADMIN_PORTAL_IMAGE="${REPO_NAME}/admin-portal-ui:latest"
export TODO_WEB_APP_IMAGE="${REPO_NAME}/todo-web-app:latest"
export TODO_WEB_SERVICE_IMAGE="${REPO_NAME}/todo-web-service:latest"
export BACKEND_IMAGE="${REPO_NAME}/baserock-facade-service"
export BACKEND_TAG="latest"
export CELERY_WORKER_IMAGE="${REPO_NAME}/celery-worker:latest"

#-- llm versions--#
export LLM_MODEL_NAME="claude-3-5-sonnet-20241022"
export VOYAGE_MODEL_NAME="voyage-3"