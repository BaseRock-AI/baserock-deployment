#!/bin/bash

set -e

source ./commons/messaging.sh
source ./minikube/minikube-vars.sh
source ./commons/docker_image.sh

chmod +x commons/docker.sh
chmod +x commons/service.sh
chmod +x minikube/minikube-status.sh

./commons/docker.sh
./commons/service.sh
./minikube/minikube-status.sh