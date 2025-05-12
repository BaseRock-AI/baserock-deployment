#!/bin/bash

# Ensure the directory exists
if [ ! -d "$DEST_DIR" ]; then
  echo "Directory $DEST_DIR does not exist. Exiting."
  exit 1
fi

echo "Loading Docker images from $DEST_DIR..."

# Iterate over all .tar files and load them
for image_tar in "$DEST_DIR"/*.tar; do
  if [ -f "$image_tar" ]; then
    echo "Loading $image_tar..."
    docker load -i "$image_tar"
  else
    echo "No .tar files found in $DEST_DIR."
    break
  fi
done

echo "All Docker images loaded."
