#!/bin/bash

source ./commons/messaging.sh

print_status "Creating Postgres init.sql ConfigMap..."

envsubst < "$(pwd)/commons/db/init.sql" | \
kubectl create configmap postgres-init-script \
  --from-file=init.sql=/dev/stdin \
  --namespace="${NAMESPACE}"