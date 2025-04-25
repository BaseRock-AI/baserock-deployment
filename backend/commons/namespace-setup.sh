source ./commons/messaging.sh
print_status "Cleaning up previous installations..."
helm uninstall "$HELM_RELEASE" -n "$NAMESPACE" 2>/dev/null || true
kubectl delete namespace "$NAMESPACE" 2>/dev/null || true


print_status "Creating namespace: $NAMESPACE"
kubectl create namespace "$NAMESPACE" || true