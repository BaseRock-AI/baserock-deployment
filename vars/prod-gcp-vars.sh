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
export LLM_PROVIDER="anthropic"
export LLM_API_KEY="<Anthropic-key>"
export VOYAGE_API_KEY="<Voyage-key>"
export BEDROCK_LLM_MODEL_NAME="<>"
export BEDROCK_BASIC_MODEL_NAME="<>"
export BEDROCK_BASIC_MAX_TOKENS="<>"
export BEDROCK_ADVANCED_MAX_TOKENS="<>"

#-optional-#
export GITHUB_APP_ID="<GITHUB-APP-DETAILS>"
export GITHUB_APP_ID_INT="<>"
export GITHUB_CLIENT_ID="<>"
export GITHUB_CLIENT_SECRET="<>"
export GITHUB_PRIVATE_KEY="<>"

export BITBUCKET_CLIENT_ID="<BITBUCKET-APP-DETAILS>"
export BITBUCKET_CLIENT_SECRET="<>"
export BITBUCKET_INSTALLATION_URL="<>"

# -- images --#
export REPO_NAME="vikasbaserock"

#-- backend-extras--#
export VALUES_YAML="backend/baserock-backend/values-gcp-prod.yaml"
export BASEROCK_EMAIL_SMTP="onprem@baserock.ai"
export BASEROCK_EMAIL_PASSWORD_SMTP="ootejotartwhagaw"

#-- todo-web-service --#
export TODO_WEB_SERVICE_SPRING_PROFILES_ACTIVE="prod"
