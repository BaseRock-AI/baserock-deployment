source ./commons/messaging.sh

# Add Helm repo for dependencies
print_status "Adding Helm repositories..."
helm repo add bitnami https://charts.bitnami.com/bitnami
helm repo update

print_status "Updating Helm dependencies..."
cd backend/baserock-backend
helm dependency update
helm dependency build
cd ..
cd ..
