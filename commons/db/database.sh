#!/bin/bash

set -e
source ./commons/messaging.sh

print_status "Running deployment script..."
chmod +x commons/db/create-initscript.sh
chmod +x commons/db/create-secrets.sh
chmod +x commons/db/deploy-postgres.sh
chmod +x commons/db/deploy-redis.sh
chmod +x commons/db/wait-for-postgres.sh

./commons/db/create-initscript.sh
./commons/db/create-secrets.sh
./commons/db/deploy-postgres.sh
./commons/db/deploy-redis.sh
./commons/db/wait-for-postgres.sh

print_status "All components deployed successfully."