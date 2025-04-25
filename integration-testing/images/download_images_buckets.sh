#!/bin/bash

# Replace this with your bucket name
DEST_DIR="."

# List all .tar files in the bucket and download them to the current directory if they don't already exist
gsutil ls "${BUCKET_NAME}/*.tar" | while read -r file; do
    # Extract the file name from the full path
    filename=$(basename "$file")
    
    echo "Checking $filename..."

    # Check if the file already exists locally
    if [ -f "$DEST_DIR/$filename" ]; then
        echo "$filename already exists, skipping download."
    else
        echo "Downloading $filename..."
        gsutil cp "$file" "$DEST_DIR/"
    fi
done

echo "All .tar files downloaded to the current directory, if not already present."
