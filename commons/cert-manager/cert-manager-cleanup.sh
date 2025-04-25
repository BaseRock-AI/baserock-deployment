source ./commons/messaging.sh


kubectl delete clusterrole cert-manager cert-manager-cainjector cert-manager-webhook cert-manager-controller-issuers cert-manager-controller-clusterissuers \
 cert-manager-controller-certificates cert-manager-cluster-view cert-manager-controller-approve:cert-manager-io cert-manager-controller-certificatesigningrequests \
  cert-manager-controller-challenges cert-manager-controller-ingress-shim cert-manager-controller-orders cert-manager-edit cert-manager-view cert-manager-webhook:subjectaccessreviews
kubectl delete clusterrolebinding cert-manager cert-manager-cainjector cert-manager-webhook cert-manager-controller-approve:cert-manager-io cert-manager-controller-certificates cert-manager-controller-certificatesigningrequests cert-manager-controller-challenges cert-manager-controller-clusterissuers \
                         cert-manager-controller-ingress-shim cert-manager-controller-issuers cert-manager-controller-orders cert-manager-webhook:subjectaccessreviews

kubectl delete crd \
    certificaterequests.cert-manager.io \
    certificates.cert-manager.io \
    challenges.acme.cert-manager.io \
    clusterissuers.cert-manager.io \
    issuers.cert-manager.io \
    orders.acme.cert-manager.io

echo "deleting namespace cert-manager"
helm uninstall cert-manager -n "${CERT_MANAGER_NAMESPACE}"
kubectl delete namespace "${CERT_MANAGER_NAMESPACE}"


print_status "delete cert manager"
helm uninstall cert-manager -n "${CERT_MANAGER_NAMESPACE}"
kubectl delete namespace "${CERT_MANAGER_NAMESPACE}"