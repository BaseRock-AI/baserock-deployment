source ./commons/messaging.sh
print_status "Loading Docker image into Minikube..."

docker pull $BACKEND_IMAGE
minikube image load $BACKEND_IMAGE