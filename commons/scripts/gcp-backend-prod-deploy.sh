#!/bin/bash

set -e

source ./commons/vars/prod-gcp.sh
source ./backend/commons/docker_image.sh

chmod +x backend/commons/helm.sh
chmod +x backend/commons/database.sh
chmod +x backend/commons/service.sh
chmod +x backend/commons/health.sh

./backend/commons/helm.sh
./commons/db/database.sh
./backend/commons/service.sh
./backend/commons/health.sh
