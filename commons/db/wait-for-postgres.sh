#!/bin/bash

source ./commons/messaging.sh

print_status "Waiting for PostgreSQL to be ready..."

kubectl wait --namespace "$NAMESPACE" \
    --for=condition=Ready pod \
    -l app.kubernetes.io/name=postgresql \
    --timeout=300s