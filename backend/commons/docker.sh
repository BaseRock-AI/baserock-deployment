source ./commons/messaging.sh
print_status "Loading Docker image into Minikube..."

COMPLETE_IMAGE="$IMAGE:$TAG"
echo "loading $COMPLETE_IMAGE"
docker pull $COMPLETE_IMAGE
minikube image load $COMPLETE_IMAGE