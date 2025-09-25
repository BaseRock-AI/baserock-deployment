#!/usr/bin/env bash
set -euo pipefail

########################################
# AWS / ECR settings – EDIT THESE
########################################
AWS_REGION="us-east-1"
AWS_ACCOUNT_ID="062853520136"    # <-- change to your AWS account
BASE_ECR="${AWS_ACCOUNT_ID}.dkr.ecr.${AWS_REGION}.amazonaws.com"

########################################
# Images list:  source_image   repo_name   tag
########################################
IMAGES=(
  # ---- Previously listed images ----
  "mongo:8.0.0                                      mongo                       8.0.0"
  "swr.cn-north-4.myhuaweicloud.com/ddn-k8s/docker.io/bitnami/postgresql:16.1.0-debian-11-r25   postgresql                 16.1.0-debian-11-r25"
  "rabbitmq:4.0.2-management                         rabbitmq                    4.0.2-management"
  "swr.cn-north-4.myhuaweicloud.com/ddn-k8s/docker.io/bitnami/redis:7.2.5-debian-12-r0          redis                       7.2.5-debian-12-r0"
  "mongo-express:1.0.2-20-alpine3.19                 mongo-express               1.0.2-20-alpine3.19"
  "quay.io/jetstack/cert-manager-cainjector:v1.15.3  cert-manager-cainjector     v1.15.3"
  "quay.io/jetstack/cert-manager-controller:v1.15.3  cert-manager-controller     v1.15.3"
  "quay.io/jetstack/cert-manager-webhook:v1.15.3     cert-manager-webhook        v1.15.3"
  "quay.io/jetstack/cert-manager-acmesolver:v1.15.3  cert-manager-acmesolver     v1.15.3"
  "quay.io/jetstack/cert-manager-startupapicheck:v1.15.3 cert-manager-startupapicheck v1.15.3"
  "registry.k8s.io/ingress-nginx/controller:v1.6.3   ingress-nginx-controller    v1.6.3"
  "registry.k8s.io/ingress-nginx/kube-webhook-certgen:v20220916-gd32f8c343 kube-webhook-certgen v20220916-gd32f8c343"
  "ghcr.io/apache/flink-kubernetes-operator:ccb10b8  flink-kubernetes-operator   ccb10b8"

  # ---- Newly added GCR images ----
  "gcr.io/production-385606/le-django-server:latest                   le-django-server              latest"
  "gcr.io/production-385606/upcaster:latest                           upcaster                       latest"
  "gcr.io/production-385606/baserock-backend/learning-engine-service:latest learning-engine-service    latest"
  "gcr.io/production-385606/client:latest                              client                         latest"
  "gcr.io/production-385606/celery-worker:latest                       celery-worker                  latest"
  "gcr.io/production-385606/sapient-backend/facade-service:latest      facade-service                 latest"
  "gcr.io/production-385606/admin-portal-ui:latest                     admin-portal-ui                latest"
  "gcr.io/production-385606/flinkjob-rabbitmq-aggregation:latest       flinkjob-rabbitmq-aggregation  latest"
  "gcr.io/production-385606/todo-web-service:latest                    todo-web-service               latest"
  "gcr.io/production-385606/todo-web-app:latest                        todo-web-app                   latest"
)

########################################
# Login to ECR
########################################
echo ">>> Logging in to Amazon ECR..."
aws ecr get-login-password --region "${AWS_REGION}" \
  | docker login --username AWS --password-stdin "${BASE_ECR}"

########################################
# Loop through images
########################################
for entry in "${IMAGES[@]}"; do
  read -r SRCIMG REPO TAG <<<"$entry"
  ECR_REPO="${BASE_ECR}/baserock/onprem/${REPO}"

  echo
  echo "========================================"
  echo "Processing $SRCIMG  ->  $ECR_REPO:$TAG"
  echo "========================================"

  # Create ECR repo if needed
  if ! aws ecr describe-repositories --repository-names "${REPO}" --region "${AWS_REGION}" >/dev/null 2>&1; then
    echo "Creating ECR repo ${ECR_REPO}"
    aws ecr create-repository --repository-name "baserock/onprem/${REPO}" --region "${AWS_REGION}" >/dev/null
  fi

  # Pull each architecture if available
  for arch in amd64 arm64; do
    echo "Pulling $SRCIMG for $arch ..."
    docker pull --platform=linux/$arch "$SRCIMG" || echo "No $arch image found for $SRCIMG"
  done

  # Build list of digests
  DIGEST_ARGS=()
  for arch in amd64 arm64; do
    digest=$(docker buildx imagetools inspect "$SRCIMG" --format '{{json .Manifest.Manifests}}' \
      | jq -r ".[] | select(.Platform.architecture==\"$arch\") | .Digest" || true)
    if [[ -n "$digest" && "$digest" != "null" ]]; then
      DIGEST_ARGS+=("${SRCIMG}@${digest}")
    fi
  done

  if [ ${#DIGEST_ARGS[@]} -eq 0 ]; then
    echo "No digests found for $SRCIMG, skipping..."
    continue
  fi

  # Create multi-arch manifest in ECR
  echo "Creating multi-arch manifest in ECR..."
  docker buildx imagetools create --tag "${ECR_REPO}:${TAG}" "${DIGEST_ARGS[@]}"

  echo "✅ Pushed ${ECR_REPO}:${TAG}"
done

echo
echo "All images processed successfully."
