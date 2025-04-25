#!/bin/bash

# Function to recursively list and process images in GCR
process_images() {
  local REPO=$1

  # Step 1: List all images in the current repository
  IMAGES=$(gcloud container images list --repository="$REPO" --format="value(name)")
  #Only specific images to download
  declare -a TARGET_IMAGES=(
    "gcr.io/production-385606/client-local"
    "gcr.io/production-385606/flinkjob-rabbitmq-aggregation"
    "gcr.io/production-385606/le-django-server"
    "gcr.io/production-385606/upcaster"
    "gcr.io/production-385606/sapient-backend/learning-engine-service"
  )

  # Step 2: Process each image in the current repository
  for IMAGE in $IMAGES; do
    # Check if the image has subdirectories (hierarchical structure)
    SUBIMAGES=$(gcloud container images list --repository="$IMAGE" --format="value(name)")

    # If subimages exist, recursively process them
    if [[ -n "$SUBIMAGES" ]]; then
      echo "Entering sub-repository: $IMAGE"
      process_images "$IMAGE"
    elif [[ " ${TARGET_IMAGES[@]} " =~ " ${IMAGE} " ]]; then
      echo "Processing image: $IMAGE"
      # Step 3: Get all tags
      TAGS=$(gcloud container images list-tags "$IMAGE" --format="get(tags)" | tr ';' '\n')

      # Check if there are tags
      if [[ -z "$TAGS" ]]; then
        echo "No tags found for image: $IMAGE"
        continue
      fi

      # Step 4: Sort the tags numerically (handling semantic versioning)
      MOST_RECENT_TAG=$(echo "$TAGS" | grep -E '^[0-9]+\.[0-9]+\.[0-9]+$' | sort -V | tail -n 1)

      # Validate that we got a tag
      if [[ -z "$MOST_RECENT_TAG" ]]; then
        echo "No valid semver tags found for image: $IMAGE"
        continue
      fi

      FULL_IMAGE="${IMAGE}:${MOST_RECENT_TAG}"
      TAR_FILE="$(basename "$IMAGE")_${MOST_RECENT_TAG}.tar"

      # Step 5: Check if the tar file already exists
      if [[ -f "$TAR_FILE" ]]; then
        echo "Tar file $TAR_FILE already exists, skipping download."
        continue
      fi

      echo "Most recent tag: $MOST_RECENT_TAG"
      echo "Pulling image: $FULL_IMAGE"

      # Step 6: Pull the image
      docker pull "$FULL_IMAGE"

      # Step 7: Save the image as a tar file
      echo "Saving image to: $TAR_FILE"
      docker image save -o "$TAR_FILE" "$FULL_IMAGE"
    else
      echo "Skipping non-matching image: $IMAGE"
    fi
  done
}

# Start by listing the top-level images from the base repository
BASE_REPO="gcr.io/production-385606"
echo "Starting to process images in repository: $BASE_REPO"
process_images "$BASE_REPO"

echo "All images have been processed."
