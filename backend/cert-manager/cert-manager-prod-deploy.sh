#!/bin/bash

set -e

chmod +x gcp/gcp-install.sh
chmod +x cert-manager/cert-manager.sh
chmod +x commons/namespace-setup.sh
chmod +x cert-manager/cert-prod-vars.sh

source ./cert-manager/cert-prod-vars.sh
source ./gcp/gcp-prod-vars.sh
source ./commons/docker_image.sh


./gcp/gcp-install.sh
./commons/namespace-setup.sh
./cert-manager/cert-manager.sh