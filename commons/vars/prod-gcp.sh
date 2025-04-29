# -- namespaces --#
export CERT_MANAGER_NAMESPACE="baserock-cert-manager"
export INGRESS_NAMESPACE="ingress-nginx"
export NAMESPACE="baserock-onprem"

# -- gke --#
export BUCKET_NAME="gs://docker-images-baserock-server"
export GKE_CLUSTER="on-prem-cluster"
export GKE_REGION="us-central1"
export PROJECT_ID="production-385606"
export HOST_BASE_URL="app.onprem.baserock.ai"
export DOMAIN="app.onprem.baserock.ai"
export STATIC_IP_ADDRESS="34.122.141.94"
export CERTIFICATE_NAME="app-baserock-onprem-prod-ssl-cert"
export SECRET_NAME="app-baserock-onprem-prod-ssl-cert"

# -- images --#
export CLIENT_IMAGE="gcr.io/production-385606/client-local:0.49.0"
export UPCASTER_IMAGE="gcr.io/production-385606/upcaster:0.206.0"
export FLINK_IMAGE="gcr.io/production-385606/flinkjob-rabbitmq-aggregation:0.42.0"
export DJANGO_IMAGE="gcr.io/production-385606/le-django-server:0.205.0"
export LE_SERVICE_IMAGE="gcr.io/production-385606/sapient-backend/learning-engine-service:0.138.0"

#-- mongo --#
export UPCASTED_COLLECTION="testUpcastedSchemaSpec"
export MONGO_DB_PASSWORD="teste"
export MONGO_DB_NAME="microservice"
export MONGO_USERNAME="user"
export MONGO_DB_USER="root"
export MONGO_PORT="27017"
export MONGO_SERVICE="mongodb-service"
export MONGO_URL="mongodb://${MONGO_DB_USER}:${MONGO_DB_PASSWORD}@${MONGO_SERVICE}:${MONGO_PORT}/"

#-- postgres --#
export POSTGRES_DB_NAME="sapient-dev"
export POSTGRES_USERNAME="postgres"
export POSTGRES_DB_PASSWORD="teste"

#--rabbitMQ --#
export MQ_HOST_NAME="rabbitmq-service"
export MQ_USERNAME="user"
export MQ_PASSWORD="password"

#-- deployment names -- #
export CLIENT_DEPLOYMENT="client-deployment"
export UPCASTER_DEPLOYMENT="upcaster-deployment"
export FLINK_JOB_NAME="flink-aggregation-job"
export LE_SERVICE_DEPLOYMENT="learning-engine"
export MONGO_DEPLOYMENT="mongodb"
export POSTGRES_DEPLOYMENT="postgres-deployment"
export DJANGO_DEPLOYMENT="python-deployment"
export MQ_DEPLOYMENT="rabbitmq-deployment"
export MONGO_SERVICE="mongodb-service"
export DJANGO_SERVICE_DEPLOYMENT="python-service"
export POSTGRES_SERVICE_DEPLOYMENT="postgres-service"
export RABBITMQ_SERVICE_DEPLOYMENT="rabbitmq-service"

#-- ingress  & Cert--#
export CLIENT_BASE_URL="/it/catalog(/|$)(.*)"
export LE_SERVICE_BASE_URL="/it/leService(/|$)(.*)"
export ISSUER_NAME="letsencrypt-production"
export CERT_SERVER="https://acme-v02.api.letsencrypt.org/directory"
export EMAIL="admin@baserock.ai"
export INGRESS_CLASS="nginx"
export HOST_PATH_TYPE="Prefix"
export INGRESS_PORT="80"

#-- port & host --#
export LE_SERVICE_PORT="80"
export LE_DJANGO_PORT="80"
export CLIENT_PORT="80"
export MONGO_EXPRESS_PORT="8081"
export RABBITMQ_PORT="5672"
export RABBITMQ_HOST="http://${RABBITMQ_SERVICE_DEPLOYMENT}.${NAMESPACE}.svc.cluster.local:${RABBITMQ_PORT}"
export POSTGRES_PORT="5432"
export POSTGRES_HOST="postgres://${POSTGRES_SERVICE_DEPLOYMENT}.${NAMESPACE}.svc.cluster.local:${POSTGRES_PORT}"
export DJANGO_SERVICE_URL="http://${DJANGO_SERVICE_DEPLOYMENT}.${NAMESPACE}.svc.cluster.local:8080"
#-- misc --#

export VALUE_VERIFICATION="false"
export USE_MINIKUBE="true"

#-- backend-extras--#
export HELM_RELEASE="baserock-backend"
export IMAGE_PULL_POLICY="Always"
export VALUES_YAML="-f backend/baserock-backend/values-commons.yaml -f backend/baserock-backend/values-gcp-prod.yaml"
export INGRESS_PATH_TYPE="Prefix"
export SCHEME="https"
export EMAIL_ID="support@baserock.ai"
export USER_COUNT=1
export LICENSE_TYPE="TRIAL"