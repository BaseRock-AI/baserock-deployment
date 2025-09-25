source ./commons/messaging.sh

CONTEXT="arn:aws:eks:${AWS_REGION}:${AWS_ACCOUNT_ID}:cluster/${EKS_CLUSTER}"
print_status "Switching context $CONTEXT"
kubectl config use-context "$CONTEXT"
print_status "Authenticating with AWS..."
aws sts get-caller-identity
# Connect to EKS
print_status "Connecting to EKS cluster: $EKS_CLUSTER in region $AWS_REGION..."
aws eks update-kubeconfig --region "$AWS_REGION" --name "$EKS_CLUSTER"

