# -- gke --#
export EKS_CLUSTER="web-quickstart"
export AWS_REGION="us-east-1"
export AWS_ACCOUNT_ID="062853520136"
export DOMAIN="awsonprem.baserock.ai"
export DOMAIN_PORT=""
export STATIC_IP_ADDRESS="44.206.13.101"
export CERTIFICATE_NAME="arn:aws:acm:us-east-1:062853520136:certificate/d13948d7-4615-4e8f-bb7d-67b38b6224c9"
export AWS_ACCESS_KEY_ID=""
export AWS_SECRET_ACCESS_KEY=""
export EIP_ALLOCATION_ID="<>"
export CERTIFICATE_NAME="<>"
export AWS_ACCESS_KEY_ID="<>"
export AWS_SECRET_ACCESS_KEY="<>"
export AWS_DEFAULT_REGION="${AWS_REGION}"
export IMAGE_PULL_SECRET="aws-pull-secret"
export IMAGE_PULL_SECRET_SERVER="${AWS_ACCOUNT_ID}.dkr.ecr.${AWS_REGION}.amazonaws.com"
export IMAGE_PULL_USERNAME="AWS"
export IMAGE_PULL_PASSWORD="$(aws ecr get-login-password --region ${AWS_REGION})"
export IMAGE_PULL_EMAIL="<>"
export AWS_NLB_NAME="<>"
export INGRESS_CLASS="nginx"
#-- config --#
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
export REPO_NAME="062853520136.dkr.ecr.us-east-1.amazonaws.com/baserock/onprem"

#-- backend-extras--#
export VALUES_YAML="backend/baserock-backend/values-aws-prod-nginx.yaml"
export BASEROCK_EMAIL_SMTP="onprem@baserock.ai"
export BASEROCK_EMAIL_PASSWORD_SMTP="ootejotartwhagaw"

#-- todo-web-service --#
export TODO_WEB_SERVICE_SPRING_PROFILES_ACTIVE="prod"


