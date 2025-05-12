#!/bin/bash
set -euo pipefail

mkdir -p "$DEST_DIR"



for image in "${IMAGES[@]}"; do
  filename=$(echo "$image" | sed 's/[^a-zA-Z0-9]/_/g').tar
  fullpath="$DEST_DIR/$filename"

  echo "Processing $image..."

  if [ -f "$fullpath" ]; then
    echo "✔️  $filename already exists, skipping."
  else
    echo "⬇️  Pulling $image..."
    docker pull "$image"

    echo "💾 Saving $image to $filename..."
    docker save "$image" -o "$fullpath"
  fi
done

echo "✅ All images processed."
