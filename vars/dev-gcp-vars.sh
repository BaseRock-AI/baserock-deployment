# -- gke --#
export BUCKET_NAME="gs://docker-images-baserock-server"
export GKE_CLUSTER="dev-on-prem"
export GKE_REGION="us-central1"
export PROJECT_ID="development-375212"
export DOMAIN="app.dev.onprem.baserock.ai"
export DOMAIN_PORT=""
export STATIC_IP_ADDRESS="34.45.23.246"
export CERTIFICATE_NAME="app-baserock-onprem-ssl-cert"
export IMAGE_PULL_SECRET="dockerhub-pull-secret"
export IMAGE_PULL_SECRET_SERVER="https://index.docker.io/v1/"
export IMAGE_PULL_USERNAME="vikasbaserock"
export IMAGE_PULL_PASSWORD="<>"
export IMAGE_PULL_EMAIL="vikas@baserock.ai"

#-- llm config --#
export LLM_API_KEY="<Anthropic-key>"
export VOYAGE_API_KEY="<Voyage-key>"
export LLM_PROVIDER="anthropic"
export BEDROCK_LLM_MODEL_NAME="<>"
export BEDROCK_BASIC_MODEL_NAME="<>"
export BEDROCK_BASIC_MAX_TOKENS="<>"
export BEDROCK_ADVANCED_MAX_TOKENS="<>"
export AWS_SECRET_ACCESS_KEY_BEDROCK="<>"
export AWS_REGION_BEDROCK="<>"

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
export VALUES_YAML="backend/baserock-backend/values-gcp.yaml"
export BASEROCK_EMAIL_SMTP="onprem@baserock.ai"
export BASEROCK_EMAIL_PASSWORD_SMTP="ootejotartwhagaw"

#-- todo-web-service --#
export TODO_WEB_SERVICE_SPRING_PROFILES_ACTIVE="dev"
export USE_LATEST_TAGS="true"

export INGRESS_CLASS="nginx"

