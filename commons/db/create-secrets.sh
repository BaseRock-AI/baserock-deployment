#!/bin/bash

source ./commons/messaging.sh

print_status "Creating Redis secret..."

kubectl create secret generic baserock-backend-redis \
  --namespace "${NAMESPACE}" \
  --from-literal=redis-password=""
