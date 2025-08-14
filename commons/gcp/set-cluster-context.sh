source ./commons/messaging.sh
# Authenticate with GCP
CONTEXT="gke_${PROJECT_ID}_${GKE_REGION}_${GKE_CLUSTER}"
print_status "Switching context"
kubectl config use-context "$CONTEXT"

print_status "Authenticating with GCP..."
#gcloud config set project "$PROJECT_ID"

# Connect to GKE
print_status "Connecting to GKE cluster: $GKE_CLUSTER in region $GKE_REGION..."
gcloud container clusters get-credentials "$GKE_CLUSTER" --region "$GKE_REGION"