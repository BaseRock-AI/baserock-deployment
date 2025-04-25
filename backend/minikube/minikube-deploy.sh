#!/bin/bash

set -e

source ./minikube/minikube-vars.sh
source ./commons/docker_image.sh

chmod +x minikube/minikube-install.sh
chmod +x commons/docker.sh
chmod +x commons/helm.sh
chmod +x commons/database.sh
chmod +x commons/service.sh
chmod +x minikube/minikube-status.sh

./minikube/minikube-install.sh
./commons/helm.sh
./commons/database.sh
./commons/docker.sh
./commons/service.sh
./minikube/minikube-status.sh
