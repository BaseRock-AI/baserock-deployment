#!/bin/bash

set -e

source ./commons/vars/dev-gcp.sh
source ./backend/commons/docker_image.sh

chmod +x backend/commons/helm.sh
chmod +x commons/db/database.sh
chmod +x backend/commons/service.sh
chmod +x backend/commons/health.sh

./backend/commons/helm.sh
echo "db update"
./commons/db/database.sh
./backend/commons/service.sh
./backend/commons/health.sh
