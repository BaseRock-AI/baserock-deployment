source ./commons/messaging.sh
# Get Minikube service URL
print_status "Fetching Minikube service URL..."
minikube service list

print_status " Minikube tunnel..."
minikube tunnel