source ./commons/messaging.sh
print_status "Cleaning up previous installations..."
kubectl delete namespace "${NAMESPACE}" 2>/dev/null || true

