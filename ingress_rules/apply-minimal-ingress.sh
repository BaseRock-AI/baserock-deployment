#!/bin/bash
# Cloud-agnostic multi-ingress deployment

# ---- Define lists of ingress names, services, and paths ----
# Initial array
INGRESS_NAMES=("client-ingress" "le-service-ingress" "le-django-service-ingress" "admin-portal-ingress" "baserock-backend-ingress")
SERVICE_NAMES=("${CLIENT_DEPLOYMENT}-service" "learning-engine-service" "python-service" "admin-portal-svc" "baserock-backend-svc")
PATHS=("${CLIENT_BASE_URL}" "${LE_SERVICE_BASE_URL}" "${LE_DJANGO_BASE_URL}" "/admin-portal" "/")
SERVICE_PORTS=(80 80 80 80 8080)
# Conditionally append
if [[ "$SAMPLE_SERVICES_TYPE" == "Yes" ]]; then
  INGRESS_NAMES+=("todo-web-app-ingress" "todo-web-service-ingress")
  SERVICE_NAMES+=("todo-web-app-service" "todo-web-service")
  PATHS+=("${TODO_WEB_APP_CONTEXT_PATH}" "${TODO_WEB_SERVICE_CONTEXT_PATH}")
  # shellcheck disable=SC2206
  SERVICE_PORTS+=(${TODO_WEB_APP_SERVER_PORT} ${TODO_WEB_SERVICE_SERVER_PORT})
fi

# ---- Minimal YAML template ----
MIN_YAML="ingress_rules/minimal-ingress.yaml"

# ---- Check arrays have same length ----
if [ ${#INGRESS_NAMES[@]} -ne ${#SERVICE_NAMES[@]} ] || [ ${#SERVICE_NAMES[@]} -ne ${#PATHS[@]} ]; then
  echo "Error: Arrays must have the same length"
  exit 1
fi

# ---- Loop through each ingress ----
for i in "${!INGRESS_NAMES[@]}"; do
  echo "Applying Ingress: ${INGRESS_NAMES[$i]} for service: ${SERVICE_NAMES[$i]} at path: ${PATHS[$i]} on port ${SERVICE_PORTS[$i]}"

  # Export service port for envsubst
  export MINIMAL_SERVICE_PORT=${SERVICE_PORTS[$i]}
  export MINIMAL_INGRESS_NAME="${INGRESS_NAMES[$i]}"
  export MINIMAL_INGRESS_SERVICE_NAME="${SERVICE_NAMES[$i]}"
  export MINIMAL_SERVICE_PATH="${PATHS[$i]}"
  export MINIMAL_PATH_TYPE="Prefix"
  envsubst < $MIN_YAML | kubectl apply -f -
done
