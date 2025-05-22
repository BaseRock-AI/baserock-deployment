#!/bin/bash

# --- LOGIN TO ECR ---
echo "Logging in to ECR..."
aws ecr get-login-password --region "$AWS_REGION" | docker login --username AWS --password-stdin "$AWS_ACCOUNT_ID.dkr.ecr.$AWS_REGION.amazonaws.com"

# --- PROCESS TAR FILES ---
for TAR_FILE in "$TAR_DIR"/*.tar; do
  echo "Processing $TAR_FILE..."

  # Load image from tar
  IMAGE_ID=$(docker load -i "$TAR_FILE" | grep "Loaded image" | awk -F': ' '{print $2}')
  echo "Loaded image: $IMAGE_ID"

  # Extract image name and tag
  IMAGE_NAME=$(echo "$IMAGE_ID" | cut -d':' -f1)
  IMAGE_TAG=$(echo "$IMAGE_ID" | cut -d':' -f2)

  # Set ECR repo name (strip namespace if needed)
  REPO_NAME=$(basename "$IMAGE_NAME")
  ECR_URL="$AWS_ACCOUNT_ID.dkr.ecr.$AWS_REGION.amazonaws.com/$REPO_PREFIX/$REPO_NAME"

  # Create ECR repo if it doesn't exist
  echo "Ensuring ECR repository exists: $REPO_NAME"
  aws ecr describe-repositories --repository-names "$REPO_PREFIX/$REPO_NAME" --region "$AWS_REGION" > /dev/null 2>&1 || \
    aws ecr create-repository --repository-name "$REPO_PREFIX/$REPO_NAME" --region "$AWS_REGION"

  # Tag and push
  echo "Tagging image as $ECR_URL:$IMAGE_TAG"
  docker tag "$IMAGE_ID" "$ECR_URL:$IMAGE_TAG"

  echo "Pushing $ECR_URL:$IMAGE_TAG to ECR..."
  docker push "$ECR_URL:$IMAGE_TAG"
  echo "Successfully pushed $REPO_NAME:$IMAGE_TAG"
done

echo "All images pushed successfully!"

