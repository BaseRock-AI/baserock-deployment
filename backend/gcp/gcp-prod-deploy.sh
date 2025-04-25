#!/bin/bash

set -e

chmod +x gcp/gcp-install.sh
chmod +x commons/helm.sh
chmod +x commons/database.sh
chmod +x gcp/gcp-setup-ingress.sh
chmod +x commons/service.sh
chmod +x gcp/gcp-status.sh
chmod +x commons/health.sh
chmod +x gcp/gcp-prod-vars.sh

source ./gcp/gcp-prod-vars.sh
source ./commons/docker_image.sh

./gcp/gcp-install.sh
./commons/helm.sh
./commons/database.sh
./gcp/gcp-setup-ingress.sh
./commons/service.sh
./gcp/gcp-status.sh
./commons/health.sh
