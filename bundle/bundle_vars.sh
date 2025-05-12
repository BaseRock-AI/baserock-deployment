export IMAGES=(
  "${CLIENT_IMAGE}"
  "${UPCASTER_IMAGE}"
  "${FLINK_IMAGE}"
  "${DJANGO_IMAGE}"
  "${LE_SERVICE_IMAGE}"
  "${ADMIN_PORTAL_IMAGE}"
  "${TODO_WEB_APP_IMAGE}"
  "${TODO_WEB_SERVICE_IMAGE}"
  "${BACKEND_IMAGE}:${BACKEND_TAG}"
)

export DEST_DIR="./bundle"

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

