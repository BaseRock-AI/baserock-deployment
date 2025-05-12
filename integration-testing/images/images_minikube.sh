#!/bin/bash

chmod +x images/download_images_buckets.sh
chmod +x images/load_images.sh

echo "Deleting existing jars"
rm -rf images/*.tar || exit
echo "Downloading images... "
./images/download_images_buckets.sh || exit
echo "Loading images from load_images.sh..."
./images/load_images.sh || exit
