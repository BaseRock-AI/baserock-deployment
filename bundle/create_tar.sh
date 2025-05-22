#!/bin/bash

# Usage: ./tar-folder.sh /path/to/folder output-name.tar.gz

FOLDER="$(pwd)"
OUTPUT="$(pwd)/bundle.tar.gz"

if [ -z "$FOLDER" ] || [ -z "$OUTPUT" ]; then
  echo "Usage: $0 /path/to/folder output-name.tar.gz"
  exit 1
fi

# Create the tar.gz archive
tar -czvf "$OUTPUT" -C "$FOLDER" .

echo "Archive created: $OUTPUT"