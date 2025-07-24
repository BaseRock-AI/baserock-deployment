#!/usr/bin/env bash

set -euo pipefail

PROJECT="production-385606"
VARS_FILE="vars/dev-gcp-vars.sh"

# Ensure we're in Bash and associative arrays are supported
if [[ -z "${BASH_VERSION:-}" ]]; then
  echo "❌ This script requires Bash. Use 'bash ./commons/get-latest-tags.sh'"
  exit 1
fi

# Detect OS for sed compatibility
if [[ "$OSTYPE" == "darwin"* ]]; then
  # macOS
  SED_CMD="sed -i '' -E"
else
  # Linux and other Unix-like systems
  SED_CMD="sed -i -E"
fi

# Declare associative map: image -> environment variable name
declare -A IMAGE_TO_ENV_MAP
IMAGE_TO_ENV_MAP=(
  ["client"]="CLIENT_IMAGE"
  ["upcaster"]="UPCASTER_IMAGE"
  ["flinkjob-rabbitmq-aggregation"]="FLINK_IMAGE"
  ["le-django-server"]="DJANGO_IMAGE"
  ["baserock-backend/learning-engine-service"]="LE_SERVICE_IMAGE"
  ["admin-portal-ui"]="ADMIN_PORTAL_IMAGE"
  ["todo-web-app"]="TODO_WEB_APP_IMAGE"
  ["todo-web-service"]="TODO_WEB_SERVICE_IMAGE"
  ["sapient-backend/facade-service"]="BACKEND_IMAGE"
  ["celery-worker"]="CELERY_WORKER_IMAGE"
)

echo "🔄 Updating image tags in $VARS_FILE..."

for image in "${!IMAGE_TO_ENV_MAP[@]}"; do
  latest_tag=$(gcloud container images list-tags "gcr.io/$PROJECT/$image" \
    --format='get(tags)' --sort-by=~timestamp --limit=1 | head -n 1 || true)

  if [[ -z "$latest_tag" ]]; then
    echo "❌ No tag found for $image, skipping..."
    continue
  fi

  env_var="${IMAGE_TO_ENV_MAP[$image]}"
  new_image="gcr.io/$PROJECT/$image:$latest_tag"

  if [[ "$env_var" == "BACKEND_IMAGE" ]]; then
    $SED_CMD "s|^(export BACKEND_IMAGE=\").*\"|\1gcr.io/$PROJECT/$image\"|" "$VARS_FILE"
    $SED_CMD "s|^(export BACKEND_TAG=\").*\"|\1$latest_tag\"|" "$VARS_FILE"
    echo "✅ Updated BACKEND_IMAGE + BACKEND_TAG with $latest_tag"
  else
    $SED_CMD "s|^(export $env_var=\").*\"|\1$new_image\"|" "$VARS_FILE"
    echo "✅ Updated $env_var with $new_image"
  fi
done

echo "✅ Done updating all image tags."
