source ./commons/messaging.sh

curr_dir="$(pwd)"

# shellcheck disable=SC2164
print_status "init sql"
#kubectl create configmap postgres-init-script --from-file="$(pwd)/commons/db/init.sql" -n $NAMESPACE

envsubst < "$(pwd)/commons/db/init.sql" | kubectl create configmap postgres-init-script --from-file=init.sql=/dev/stdin --namespace=${NAMESPACE}
#envsubst < integration-testing/commons/init.sql | kubectl create configmap postgres-init-scripts-it --from-file=init.sql=/dev/stdin --namespace=${NAMESPACE}

print_status "cd curr dir"
cd "$curr_dir"

echo "pwd : $(pwd)"

print_status "Deploying PostgreSQL..."
helm upgrade --install postgresql bitnami/postgresql \
    --namespace $NAMESPACE \
    --set auth.username=postgres \
    --set auth.password=postgres123 \
    --set auth.database=baserock-dev \
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

kubectl create secret generic baserock-backend-redis \
  --namespace baserock-backend \
  --from-literal=redis-password=""

  # Deploy Redis to GCP
print_status "Deploying Redis..."
helm upgrade --install my-redis bitnami/redis \
  --namespace $NAMESPACE \
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

# Wait for PostgreSQL to be ready
print_status "Waiting for PostgreSQL to be ready..."
kubectl wait --namespace $NAMESPACE \
    --for=condition=Ready pod \
    -l app.kubernetes.io/name=postgresql \
    --timeout=300s