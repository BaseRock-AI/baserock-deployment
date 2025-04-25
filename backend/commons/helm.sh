source ./commons/messaging.sh
# Load Docker image into Minikube (Ensures local deployment)


# Add Helm repo for dependencies
print_status "Adding Helm repositories..."
helm repo add bitnami https://charts.bitnami.com/bitnami
helm repo update

print_status "Updating Helm dependencies..."
cd baserock-backend || exit
helm dependency update
helm dependency build
cd ..