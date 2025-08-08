#!/bin/bash

source ./commons/messaging.sh

print_status "Deploying PostgreSQL..."

if [ -z "$POSTGRES_IMAGE" ]; then
  echo "🚀 Deploying PostgreSQL with default Bitnami image..."
  helm upgrade --install postgresql ./postgresql \
      --namespace $NAMESPACE \
      --set auth.username="${POSTGRES_USERNAME}" \
      --set auth.password="${POSTGRES_DB_PASSWORD}" \
      --set auth.database="${POSTGRES_DB_NAME}" \
      --set primary.persistence.enabled=false \
      --set primary.extraVolumes[0].name=init-script \
      --set primary.extraVolumes[0].configMap.name=postgres-init-script \
      --set primary.extraVolumeMounts[0].name=init-script \
      --set primary.extraVolumeMounts[0].mountPath=/docker-entrypoint-initdb.d \
      --set primary.resources.requests.ephemeral-storage=512Mi \
      --set primary.resources.limits.ephemeral-storage=1Gi \
      --set primary.resources.requests.cpu="${POSTGRES_CPUS}" \
      --set primary.resources.requests.memory="${POSTGRES_MEMORY}" \
      --set primary.resources.limits.cpu="${POSTGRES_CPUS}" \
      --set primary.resources.limits.memory="${POSTGRES_MEMORY}" \
      --timeout 10m
else
  echo "🚀 Deploying PostgreSQL with custom image: $POSTGRES_IMAGE"
  POSTGRES_IMAGE_REPO=$(echo "$POSTGRES_IMAGE" | cut -d: -f1)
  POSTGRES_IMAGE_TAG=$(echo "$POSTGRES_IMAGE" | cut -d: -f2)
  helm upgrade --install postgresql ./postgresql \
    --namespace "$NAMESPACE" \
    --set image.registry="" \
    --set image.repository="$POSTGRES_IMAGE_REPO" \
    --set image.tag="$POSTGRES_IMAGE_TAG" \
    --set auth.username="${POSTGRES_USERNAME}" \
    --set auth.password="${POSTGRES_DB_PASSWORD}" \
    --set auth.database="${POSTGRES_DB_NAME}" \
    --set primary.persistence.enabled=false \
    --set primary.extraVolumes[0].name=init-script \
    --set primary.extraVolumes[0].configMap.name=postgres-init-script \
    --set primary.extraVolumeMounts[0].name=init-script \
    --set primary.extraVolumeMounts[0].mountPath=/docker-entrypoint-initdb.d \
    --set primary.resources.requests.ephemeral-storage=512Mi \
    --set primary.resources.limits.ephemeral-storage=1Gi \
    --set primary.resources.requests.cpu="${POSTGRES_CPUS}" \
    --set primary.resources.requests.memory="${POSTGRES_MEMORY}" \
    --set primary.resources.limits.cpu="${POSTGRES_CPUS}" \
    --set primary.resources.limits.memory="${POSTGRES_MEMORY}" \
    --timeout 10m
fi
