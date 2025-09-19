#!/bin/bash

set -e

DOCKERHUB_ACC="vikasbaserock"
ECR_REGISTRY="062853520136.dkr.ecr.us-east-1.amazonaws.com"
ECR_REGISTRY_NAME="baserock/onprem"
GCR_REGISTRY="gcr.io/production-385606"

IMAGE_PATHS=(
  "gcr.io/production-385606/le-django-server"
  "gcr.io/production-385606/upcaster"
  "gcr.io/production-385606/baserock-backend/learning-engine-service"
  "gcr.io/production-385606/client"
  "gcr.io/production-385606/celery-worker"
  "gcr.io/production-385606/sapient-backend/facade-service"
  "gcr.io/production-385606/admin-portal-ui"
  "gcr.io/production-385606/flinkjob-rabbitmq-aggregation"
  "gcr.io/production-385606/todo-web-service"
  "gcr.io/production-385606/todo-web-app"
  "mongo"
  "swr.cn-north-4.myhuaweicloud.com/ddn-k8s/docker.io/bitnami/postgresql"
  "rabbitmq"
  "swr.cn-north-4.myhuaweicloud.com/ddn-k8s/docker.io/bitnami/redis"
  "mongo-express"
  "quay.io/jetstack/cert-manager-cainjector"
  "quay.io/jetstack/cert-manager-controller"
  "quay.io/jetstack/cert-manager-webhook"
  "quay.io/jetstack/cert-manager-acmesolver"
  "quay.io/jetstack/cert-manager-startupapicheck"
  "registry.k8s.io/ingress-nginx/controller"
  "registry.k8s.io/ingress-nginx/kube-webhook-certgen"
  "ghcr.io/apache/flink-kubernetes-operator"
)
#   "registry.k8s.io/ingress-nginx/kube-webhook-certgen:v20220916-gd32f8c343@sha256:39c5b2e3310dc4264d638ad28d9d1d96c4cbb2b2dcfb52368fe4e3c63f61e10f"
# Corresponding tags for each image



TAGS=(
  "0.412.1-release-09-11-2025.4"
  "0.412.1-release-09-11-2025.5"
  "0.228.1-release-09-11-2025.0"
  "0.112.1-release-09-11-2025.0"
  "0.412.1-release-09-11-2025.3"
  "1.221.0"
  "0.12.1-SM-697.1"
  "0.58.21-release-07-23-2025.0"
  "0.0.2"
  "0.0.1"
  "8.0.0"
  "16.1.0-debian-11-r25"
  "4.0.2-management"
  "7.2.5-debian-12-r0"
  "1.0.2-20-alpine3.19"
  "v1.15.3"
  "v1.15.3"
  "v1.15.3"
  "v1.15.3"
  "v1.15.3"
  "v1.6.3"
  "v20220916-gd32f8c343"
  "ccb10b8"
)

# Matching DockerHub repo names (optional override)



DOCKERHUB_REPOS=(
  "le-django-server"
  "upcaster"
  "learning-engine-service"
  "client"
  "celery-worker"
  "facade-service"
  "admin-portal-ui"
  "flinkjob-rabbitmq-aggregation"
  "todo-web-service"
  "todo-web-app"
  "mongo"
  "postgresql"
  "rabbitmq"
  "redis"
  "mongo-express"
  "cert-manager-cainjector"
  "cert-manager-controller"
  "cert-manager-webhook"
  "cert-manager-acmesolver"
  "cert-manager-startupapicheck"
  "ingress-nginx/controller"
  "ingress-nginx/kube-webhook-certgen"
  "apache/flink-kubernetes-operator"
)

# Authenticate to AWS ECR
echo "🔐 Authenticating to AWS ECR..."
aws ecr get-login-password --region us-east-1 | docker login --username AWS --password-stdin $ECR_REGISTRY
echo "🔐 Authenticated to AWS ECR..."

# Create ECR repositories if they don't exist
#echo "🏗️  Creating ECR repositories..."
#for REPO in "${DOCKERHUB_REPOS[@]}"; do
#  echo "Creating repository: $ECR_REGISTRY_NAME/$REPO"
#  aws ecr create-repository --repository-name "$ECR_REGISTRY_NAME/$REPO" --region us-east-1 2>/dev/null || echo "Repository $REPO already exists"
#done

#export DOCKER_DEFAULT_PLATFORM="linux/amd64"

for i in "${!IMAGE_PATHS[@]}"; do
  IMAGE_PATH="${IMAGE_PATHS[$i]}"
  TAG="${TAGS[$i]}"
  REPO="${DOCKERHUB_REPOS[$i]}"

  IMAGE_WITH_TAG="$IMAGE_PATH:$TAG"
#  DOCKERHUB_IMAGE="$DOCKERHUB_ACC/$REPO"
  ECR_IMAGE="$ECR_REGISTRY/$ECR_REGISTRY_NAME/$REPO"
  GCR_IMAGE="$GCR_REGISTRY/$REPO"

  echo "Processing $IMAGE_WITH_TAG..."
  docker pull "$IMAGE_WITH_TAG"
  
  # Tag for DockerHub
#   docker tag "$IMAGE_WITH_TAG" "$DOCKERHUB_IMAGE:$TAG"
#   docker tag "$IMAGE_WITH_TAG" "$DOCKERHUB_IMAGE:latest"

  # Tag for ECR
  echo $IMAGE_WITH_TAG
  echo $GCR_IMAGE
   if [[ "$IMAGE_WITH_TAG" != *"$GCR_REGISTRY"* ]]; then
       echo "Image is NOT from the GCR registry"
       docker tag "$IMAGE_WITH_TAG" "$GCR_IMAGE:$TAG"
       docker tag "$IMAGE_WITH_TAG" "$GCR_IMAGE:latest"
       docker push "$GCR_IMAGE:$TAG"
       docker push "$GCR_IMAGE:latest"
   fi

   docker tag "$IMAGE_WITH_TAG" "$ECR_IMAGE:$TAG"
   docker tag "$IMAGE_WITH_TAG" "$ECR_IMAGE:latest"
  
  # Push to DockerHub
   echo "📤 Pushing to DockerHub..."
#   docker push "$DOCKERHUB_IMAGE:$TAG"
#   docker push "$DOCKERHUB_IMAGE:latest"
  
  # Push to ECR
  echo "📤 Pushing to AWS ECR..."
  docker push "$ECR_IMAGE:$TAG"
  docker push "$ECR_IMAGE:latest"

  echo "✔ Finished pushing $REPO to both DockerHub and ECR"
done

echo "✅ All images transferred successfully to DockerHub and AWS ECR."
