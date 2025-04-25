#!/bin/bash

set -e
source ./gcp/gcp-vars.sh
source ./commons/docker_image.sh

chmod +x commons/service.sh
chmod +x gcp/gcp-status.sh

./commons/service.sh
./gcp/gcp-status.sh