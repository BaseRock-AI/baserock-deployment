# -- gke --#
export BUCKET_NAME="gs://docker-images-baserock-server"
export GKE_CLUSTER="on-prem-cluster"
export GKE_REGION="us-central1"
export PROJECT_ID="production-385606"
export DOMAIN="app.onprem.baserock.ai"
export DOMAIN_PORT=""
export STATIC_IP_ADDRESS="34.122.141.94"
export CERTIFICATE_NAME="app-baserock-onprem-prod-ssl-cert"
export IMAGE_PULL_SECRET=""
export IMAGE_PULL_SECRET_SERVER="https://gcr.io"
export IMAGE_PULL_USERNAME="_json_key"
export IMAGE_PULL_PASSWORD="$(cat commons/aws/key.json)"
export IMAGE_PULL_EMAIL="lumber-image-puller@production-385606.iam.gserviceaccount.com"

export ADMIN_EMAIL="<>"

#-- config --#
export LLM_API_KEY="<Anthropic-key>"
export VOYAGE_API_KEY="<Voyage-key>"
export GITHUB_APP_ID="<GITHUB-APP-DETAILS>"
export BASEROCK_EMAIL_SMTP="onprem@baserock.ai"
export BASEROCK_EMAIL_PASSWORD_SMTP="ootejotartwhagaw"

#-optional-#
export GITHUB_APP_ID_INT="<>"
export GITHUB_CLIENT_ID="<>"
export GITHUB_CLIENT_SECRET="<>"
export GITHUB_PRIVATE_KEY="<>"

export BITBUCKET_CLIENT_ID="<>"
export BITBUCKET_CLIENT_SECRET="<>"
export BITBUCKET_INSTALLATION_URL="<>"

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
export CELERY_WORKER_IMAGE="gcr.io/production-385606/celery-worker:celery-worker-0.318.0"
export MONGODB_IMAGE="mongo:8.0.0"
export POSTGRES_IMAGE="bitnami/postgresql:16.1.0-debian-11-r25"
export RABBITMQ_IMAGE="rabbitmq:4.0.2-management"
export REDIS_IMAGE="bitnami/redis:7.2.4"
export MONGO_EXPRESS_IMAGE="mongo-express:1.0.2-20-alpine3.19"
export CERT_MANAGER_CONTROLLER_IMAGE="quay.io/jetstack/cert-manager-controller"
export CERT_MANAGER_WEBHOOK_IMAGE="quay.io/jetstack/cert-manager-webhook"
export CERT_MANAGER_CAINJECTOR_IMAGE="quay.io/jetstack/cert-manager-cainjector"
export CERT_MANAGER_ACMESOLVER_IMAGE="quay.io/jetstack/cert-manager-acmesolver"
export CERT_MANAGER_STARTUPIPCHECK_IMAGE="quay.io/jetstack/cert-manager-startupapicheck"
export INGRESS_CONTROLLER_IMAGE="registry.k8s.io/ingress-nginx/kube-webhook-certgen:v20220916-gd32f8c343@sha256:39c5b2e3310dc4264d638ad28d9d1d96c4cbb2b2dcfb52368fe4e3c63f61e10f"
export INGRESS_CERTGEN_IMAGE="registry.k8s.io/ingress-nginx/kube-webhook-certgen:v20220916-gd32f8c343@sha256:39c5b2e3310dc4264d638ad28d9d1d96c4cbb2b2dcfb52368fe4e3c63f61e10f"
export CERT_MANAGER_VERSION="v1.15.3"
export INGRESS_CLASS="nginx"
#-- backend-extras--#
export VALUES_YAML="backend/baserock-backend/values-gcp-prod.yaml"

#-- todo-web-service --#
export TODO_WEB_SERVICE_SPRING_PROFILES_ACTIVE="prod"

