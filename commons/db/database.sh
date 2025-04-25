source ./commons/messaging.sh

curr_dir="$(pwd)"

# shellcheck disable=SC2164
print_status "init sql"
kubectl create configmap postgres-init-script --from-file="$(pwd)/commons/db/init.sql" -n $NAMESPACE
print_status "cd curr dir"
cd "$curr_dir"

echo "pwd : $(pwd)"

print_status "Deploying PostgreSQL..."
helm upgrade --install postgresql bitnami/postgresql \
    --namespace $NAMESPACE \
    --set auth.username=postgres \
    --set auth.password=postgres123 \
    --set auth.database=testdb \
    --set primary.persistence.enabled=true \
    --set primary.persistence.size=1Gi \
    --set primary.extraVolumes[0].name=init-script \
    --set primary.extraVolumes[0].configMap.name=postgres-init-script \
    --set primary.extraVolumeMounts[0].name=init-script \
    --set primary.extraVolumeMounts[0].mountPath=/docker-entrypoint-initdb.d \
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
  --set master.persistence.enabled=true \
  --set master.persistence.size=5Gi

# Wait for PostgreSQL to be ready
print_status "Waiting for PostgreSQL to be ready..."
kubectl wait --namespace $NAMESPACE \
    --for=condition=Ready pod \
    -l app.kubernetes.io/name=postgresql \
    --timeout=300s