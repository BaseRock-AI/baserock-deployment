#!/bin/bash

set -e

chmod +x initial/cert-manager.sh
chmod +x commons/namespace-setup.sh
chmod +x gcp/dev-gcp-vars.sh
source ./gcp/dev-gcp-vars.sh

./initial/cert-manager.sh