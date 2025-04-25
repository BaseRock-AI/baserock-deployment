#!/bin/bash

set -e
source ./gcp/gcp-prod-vars.sh
source ./commons/docker_image.sh

chmod +x commons/service.sh
chmod +x gcp/gcp-status.sh
chmod +x gcp/gcp-install.sh

./gcp/gcp-install.sh
./commons/service.sh
./gcp/gcp-status.sh