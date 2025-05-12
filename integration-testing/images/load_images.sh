#!/bin/bash

echo "$(pwd)"

echo "$USE_MINIKUBE"
# Step 1: Traverse the current directory and find all .tar files
find . -name "*.tar" | while read TAR_FILE; do
  echo "Found tar file: $TAR_FILE"

  if [ "$USE_MINIKUBE" = true ]; then
    # Step 2: Load the tar file into Minikube's Docker environment
    echo "Loading image from $TAR_FILE into Minikube..."
    minikube image load "$TAR_FILE"

    # Check if the image load was successful
    if [[ $? -ne 0 ]]; then
      echo "Failed to load image from $TAR_FILE into Minikube"
      continue
    fi

    echo "Successfully loaded $TAR_FILE into Minikube."
  else
    # Step 2: Load the tar file into Docker directly
    echo "Loading image from $TAR_FILE into Docker..."
    docker load -i "$TAR_FILE"

    # Check if the image load was successful
    if [[ $? -ne 0 ]]; then
      echo "Failed to load image from $TAR_FILE into Docker"
      continue
    fi

    echo "Successfully loaded $TAR_FILE into Docker."
  fi
done

echo "All tar files have been processed."
