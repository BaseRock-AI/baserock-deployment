#!/bin/bash

# Function to check if a Helm repo already exists
check_repo_exists() {
  helm repo list | grep -w "$1" > /dev/null 2>&1
}

echo "check_repo_exists jetstack"

# Add the jetstack repository only if it doesn't exist
if ! check_repo_exists "jetstack"; then
  helm repo add jetstack https://charts.jetstack.io --force-update
else
  echo "Helm repo 'jetstack' already exists."
fi
#
#kubectl delete namespace cert-manager
##
#kubectl delete clusterrole cert-manager cert-manager-cainjector cert-manager-webhook cert-manager-controller-issuers cert-manager-controller-clusterissuers \
# cert-manager-controller-certificates cert-manager-cluster-view cert-manager-controller-approve:cert-manager-io cert-manager-controller-certificatesigningrequests \
#  cert-manager-controller-challenges cert-manager-controller-ingress-shim cert-manager-controller-orders cert-manager-edit cert-manager-view cert-manager-webhook:subjectaccessreviews
#kubectl delete clusterrolebinding cert-manager cert-manager-cainjector cert-manager-webhook cert-manager-controller-approve:cert-manager-io cert-manager-controller-certificates cert-manager-controller-certificatesigningrequests cert-manager-controller-challenges cert-manager-controller-clusterissuers \
#                         cert-manager-controller-ingress-shim cert-manager-controller-issuers cert-manager-controller-orders cert-manager-webhook:subjectaccessreviews
#
#kubectl delete crd \
#    certificaterequests.cert-manager.io \
#    certificates.cert-manager.io \
#    challenges.acme.cert-manager.io \
#    clusterissuers.cert-manager.io \
#    issuers.cert-manager.io \
#    orders.acme.cert-manager.io
#
#echo "deleting namespace cert-manager"
#helm uninstall cert-manager -n "${CERT_MANAGER_NAMESPACE}"
#kubectl delete namespace "${CERT_MANAGER_NAMESPACE}"

echo "check if cert-manager exists"
# Check if cert-manager is already installed
if ! helm status cert-manager -n "${CERT_MANAGER_NAMESPACE}" > /dev/null 2>&1; then
  echo "CERT-MANAGER deployment"
  helm install \
    cert-manager jetstack/cert-manager \
    -n "${CERT_MANAGER_NAMESPACE}" \
    --create-namespace \
    --version 1.15.3 \
    --set global.leaderElection.namespace="${CERT_MANAGER_NAMESPACE}" \
    --set crds.enabled=true
else
  echo "cert-manager is already installed in namespace ${CERT_MANAGER_NAMESPACE}."
fi
helm repo update

echo "check_repo_exists flink-operator-repo"
if check_repo_exists "flink-operator-repo"; then
  helm repo remove flink-operator-repo
fi

echo "helm repo add flink-operator-repo "
# Add the Flink operator repo only if it doesn't exist
if ! check_repo_exists "flink-operator-repo"; then
  helm repo add flink-operator-repo https://archive.apache.org/dist/flink/flink-kubernetes-operator-1.7.0/
else
  echo "Helm repo 'flink-operator-repo' already exists."
fi


# Check if the flink-kubernetes-operator is already installed
if ! helm status flink-kubernetes-operator -n "${NAMESPACE}" > /dev/null 2>&1; then
    echo "flink-kubernetes-operator deployment"
  helm install flink-kubernetes-operator flink-operator-repo/flink-kubernetes-operator -n "${NAMESPACE}"
else
  echo "flink-kubernetes-operator is already installed in namespace ${NAMESPACE}."
fi