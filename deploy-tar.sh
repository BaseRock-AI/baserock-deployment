#!/bin/bash

source ./commons/messaging.sh

export ENV="dev"
export DEPLOY_TYPE="Full Install"
export BASEROCK_CLOUD_OPTION_TYPE="aws"
export CERT_TYPE_OPTION="Cloud"
export CERT_MANAGER_OPTION_TYPE="Yes"

source ./vars/tar-vars.sh
source ./vars/common-vars.sh

chmod +x script.sh
chmod +x bundle/push_to_ecr.sh
./bundle/push_to_ecr.sh
./script.sh