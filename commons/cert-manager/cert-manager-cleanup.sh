source ./commons/messaging.sh


echo "CERT MANAGER CLEANUP"

kubectl delete clusterrole cert-manager cert-manager-cainjector cert-manager-webhook cert-manager-controller-issuers cert-manager-controller-clusterissuers \
 cert-manager-controller-certificates cert-manager-cluster-view cert-manager-controller-approve:cert-manager-io cert-manager-controller-certificatesigningrequests \
  cert-manager-controller-challenges cert-manager-controller-ingress-shim cert-manager-controller-orders cert-manager-edit cert-manager-view cert-manager-webhook:subjectaccessreviews
kubectl delete clusterrolebinding cert-manager cert-manager-cainjector cert-manager-webhook cert-manager-controller-approve:cert-manager-io cert-manager-controller-certificates cert-manager-controller-certificatesigningrequests cert-manager-controller-challenges cert-manager-controller-clusterissuers \
                         cert-manager-controller-ingress-shim cert-manager-controller-issuers cert-manager-controller-orders cert-manager-webhook:subjectaccessreviews

kubectl delete validatingwebhookconfiguration cert-manager-webhook
kubectl delete mutatingwebhookconfiguration cert-manager-webhook

kubectl delete crd \
    certificaterequests.cert-manager.io \
    certificates.cert-manager.io \
    challenges.acme.cert-manager.io \
    clusterissuers.cert-manager.io \
    issuers.cert-manager.io \
    orders.acme.cert-manager.io

# Remove finalizers from challenges
for c in $(kubectl get challenges.acme.cert-manager.io -n onpremise-baserock -o jsonpath='{.items[*].metadata.name}'); do
  echo "Patching challenge: $c"
  kubectl patch challenge.acme.cert-manager.io "$c" -n onpremise-baserock -p '{"metadata":{"finalizers":[]}}' --type=merge
done

# Remove finalizers from orders
for o in $(kubectl get orders.acme.cert-manager.io -n onpremise-baserock -o jsonpath='{.items[*].metadata.name}'); do
  echo "Patching order: $o"
  kubectl patch order.acme.cert-manager.io "$o" -n onpremise-baserock -p '{"metadata":{"finalizers":[]}}' --type=merge
done

# Now delete the resources cleanly
kubectl delete challenges.acme.cert-manager.io -n onpremise-baserock --all
kubectl delete orders.acme.cert-manager.io -n onpremise-baserock --all

echo "deleting namespace ${CERT_MANAGER_NAMESPACE}"
helm uninstall cert-manager -n "${CERT_MANAGER_NAMESPACE}"
kubectl delete namespace "${CERT_MANAGER_NAMESPACE}"