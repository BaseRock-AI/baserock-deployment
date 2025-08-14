# -- gke --#
export EKS_CLUSTER="<>"
export AWS_REGION="<>"
export AWS_ACCOUNT_ID="<>"
export DOMAIN="<>"
export DOMAIN_PORT=""
export STATIC_IP_ADDRESS="<>"
export CERTIFICATE_NAME="<>"
export IMAGE_PULL_SECRET="aws-pull-secret"
export IMAGE_PULL_SECRET_SERVER="<aws_account_id>.dkr.ecr.${AWS_REGION}.amazonaws.com"
export IMAGE_PULL_USERNAME="AWS"
export IMAGE_PULL_PASSWORD="$(aws ecr get-login-password --region ${AWS_REGION})"
export IMAGE_PULL_EMAIL="<EMAIL>"
export AWS_ACCESS_KEY_ID=""
export AWS_SECRET_ACCESS_KEY=""
#-- llm config --#
export LLM_API_KEY="<Anthropic-key>"
export VOYAGE_API_KEY="<Voyage-key>"
export LLM_PROVIDER="anthropic"
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
export REPO_NAME="<REPO_NAME>"

#-- backend-extras--#
export VALUES_YAML="backend/baserock-backend/values-aws-dev.yaml"
export BASEROCK_EMAIL_SMTP="onprem@baserock.ai"
export BASEROCK_EMAIL_PASSWORD_SMTP="ootejotartwhagaw"
#-- todo-web-service --#
export TODO_WEB_SERVICE_SPRING_PROFILES_ACTIVE="dev"
