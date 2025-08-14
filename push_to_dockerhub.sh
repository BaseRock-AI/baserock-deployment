#!/bin/bash

set -e

DOCKERHUB_ACC="vikasbaserock"
GCR_PREFIX="gcr.io/production-385606"
ECR_REGISTRY="062853520136.dkr.ecr.us-east-1.amazonaws.com"
ECR_REGISTRY_NAME="baserock/onprem"

# Image paths (relative to GCR_PREFIX)
IMAGE_PATHS=(
  "le-django-server"
  "upcaster"
  "baserock-backend/learning-engine-service"
  "client"
  "celery-worker"
  "sapient-backend/facade-service"
)

# Corresponding tags for each image
TAGS=(
  "0.363.3-release-08-12-2025.0"
  "0.363.3-release-08-12-2025.1"
  "0.218.1-release-08-12-2025.0"
  "0.97.1-release-08-12-2025.1"
  "0.363.3-release-08-12-2025.2"
  "1.215.0"
)

# Matching DockerHub repo names (optional override)
DOCKERHUB_REPOS=(
  "le-django-server"
  "upcaster"
  "learning-engine-service"
  "client"
  "celery-worker"
  "facade-service"
)

# Authenticate to AWS ECR
echo "🔐 Authenticating to AWS ECR..."
aws ecr get-login-password --region us-east-1 | docker login --username AWS --password-stdin $ECR_REGISTRY

# Create ECR repositories if they don't exist
echo "🏗️  Creating ECR repositories..."
for REPO in "${DOCKERHUB_REPOS[@]}"; do
  echo "Creating repository: $ECR_REGISTRY_NAME/$REPO"
  aws ecr create-repository --repository-name "$ECR_REGISTRY_NAME/$REPO" --region us-east-1 2>/dev/null || echo "Repository $REPO already exists"
done

for i in "${!IMAGE_PATHS[@]}"; do
  GCR_PATH="${IMAGE_PATHS[$i]}"
  TAG="${TAGS[$i]}"
  REPO="${DOCKERHUB_REPOS[$i]}"

  GCR_IMAGE="$GCR_PREFIX/$GCR_PATH:$TAG"
  DOCKERHUB_IMAGE="$DOCKERHUB_ACC/$REPO"
  ECR_IMAGE="$ECR_REGISTRY/$ECR_REGISTRY_NAME/$REPO"

  echo "Processing $GCR_IMAGE..."

  docker pull "$GCR_IMAGE"
  
  # Tag for DockerHub
   docker tag "$GCR_IMAGE" "$DOCKERHUB_IMAGE:$TAG"
   docker tag "$GCR_IMAGE" "$DOCKERHUB_IMAGE:latest"
  
  # Tag for ECR
   docker tag "$GCR_IMAGE" "$ECR_IMAGE:$TAG"
   docker tag "$GCR_IMAGE" "$ECR_IMAGE:latest"
  
  # Push to DockerHub
   echo "📤 Pushing to DockerHub..."
   docker push "$DOCKERHUB_IMAGE:$TAG"
   docker push "$DOCKERHUB_IMAGE:latest"
  
  # Push to ECR
  echo "📤 Pushing to AWS ECR..."
#  docker push "$ECR_IMAGE:$TAG"
#  docker push "$ECR_IMAGE:latest"

  echo "✔ Finished pushing $REPO to both DockerHub and ECR"
done

echo "✅ All images transferred successfully to DockerHub and AWS ECR."
