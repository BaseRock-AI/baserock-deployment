source ./commons/messaging.sh
# Fetch the external IP of the application
print_status "Fetching GKE service external IP..."
kubectl get svc -n $NAMESPACE
