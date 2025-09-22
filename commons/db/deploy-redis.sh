#!/bin/bash

source ./commons/messaging.sh

print_status "Deploying Redis..."

if [ -z "$REDIS_IMAGE" ]; then
  echo "🚀 Deploying Redis with default Bitnami image..."
  helm upgrade --install my-redis ./redis \
    --namespace "$NAMESPACE" \
    --set replica.replicaCount=0 \
    --set fullnameOverride=baserock-backend-redis \
    --set service.ports.redis=6379 \
    --set auth.enabled=false \
    --set master.persistence.enabled=false \
    --set master.resources.requests.ephemeral-storage=512Mi \
    --set master.resources.limits.ephemeral-storage=1Gi \
    --set master.resources.requests.cpu="${REDIS_CPUS}" \
    --set master.resources.requests.memory="${REDIS_MEMORY}" \
    --set master.resources.limits.cpu="${REDIS_CPUS}" \
    --set master.resources.limits.memory="${REDIS_MEMORY}"
else
  echo "🚀 Deploying Redis with custom image: $REDIS_IMAGE"
  REDIS_IMAGE_REPO=$(echo "$REDIS_IMAGE" | cut -d: -f1)
  REDIS_IMAGE_TAG=$(echo "$REDIS_IMAGE" | cut -d: -f2)
  helm upgrade --install my-redis ./redis \
    --namespace "$NAMESPACE" \
    --set replica.replicaCount=0 \
    --set fullnameOverride=baserock-backend-redis \
    --set service.ports.redis=6379 \
    --set auth.enabled=false \
    --set master.persistence.enabled=false \
    --set image.registry="" \
    --set image.repository="$REDIS_IMAGE_REPO" \
    --set image.tag="$REDIS_IMAGE_TAG" \
    --set master.resources.requests.ephemeral-storage=512Mi \
    --set master.resources.limits.ephemeral-storage=1Gi \
    --set master.resources.requests.cpu="${REDIS_CPUS}" \
    --set master.resources.requests.memory="${REDIS_MEMORY}" \
    --set master.resources.limits.cpu="${REDIS_CPUS}" \
    --set master.resources.limits.memory="${REDIS_MEMORY}"
fi
