#!/bin/bash
source ./commons/messaging.sh

kubectl create serviceaccount "$K8S_SERVICE_ACCOUNT_NAME" -n "$NAMESPACE"

if [[ "$BASEROCK_CLOUD_OPTION_TYPE" == "aws" && "$EKS_IRSA_ROLE_ARN" != "" ]]; then

  kubectl annotate serviceaccount "$K8S_SERVICE_ACCOUNT_NAME" \
    -n "${NAMESPACE}" \
    eks.amazonaws.com/role-arn="$EKS_IRSA_ROLE_ARN" \
    --overwrite

elif [[ "$BASEROCK_CLOUD_OPTION_TYPE" == "gcp" && "$GCP_SERVICE_ACCOUNT_NAME" != "" ]]; then

  kubectl annotate serviceaccount "$K8S_SERVICE_ACCOUNT_NAME" \
    iam.gke.io/gcp-service-account="$GCP_SERVICE_ACCOUNT_NAME" \
    -n "${NAMESPACE}" \
    --overwrite

fi

for kind in deployment statefulset daemonset job; do
  for r in $(kubectl get $kind -n "$NAMESPACE" -o name); do
    kubectl patch "$r" -n "$NAMESPACE" \
      --type='strategic' \
      -p "{\"spec\":{\"template\":{\"spec\":{\"serviceAccountName\":\"$K8S_SERVICE_ACCOUNT_NAME\"}}}}"
  done
done

for r in $(kubectl get cronjob -n "$NAMESPACE" -o name); do
  kubectl patch "$r" -n "$NAMESPACE" \
    --type='strategic' \
    -p "{\"spec\":{\"jobTemplate\":{\"spec\":{\"template\":{\"spec\":{\"serviceAccountName\":\"$K8S_SERVICE_ACCOUNT_NAME\"}}}}}}"
done
