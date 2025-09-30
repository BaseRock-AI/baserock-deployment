source ./commons/messaging.sh

# Add Helm repo for dependencies
print_status "Adding Helm repositories..."
helm repo update

print_status "Updating Helm dependencies..."
helm dependency update
helm dependency build
