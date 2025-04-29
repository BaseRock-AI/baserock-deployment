#!/bin/bash

source ./commons/messaging.sh


# Step 1: Select Environment
while true; do
    echo "Select Environment:"
    echo "1) minikube"
    echo "2) gcp"
    echo "3) prod"
    read -p "#? " ENV_OPTION

    case $ENV_OPTION in
        1) ENV="minikube"; break;;
        2) ENV="dev"; break;;
        3) ENV="prod"; break;;
        *) echo "Invalid option. Please select again.";;
    esac
done

# Step 2: Select Deployment Type
while true; do
    echo "Choose Deployment Type:"
    echo "1) Full Install"
    echo "2) Service Redeploy"
    read -p "#? " DEPLOY_OPTION

    case $DEPLOY_OPTION in
        1) DEPLOY_TYPE="Full Install"; break;;
        2) DEPLOY_TYPE="Service Redeploy"; break;;
        *) echo "Invalid option. Please select again.";;
    esac
done

print_status "Environment: $ENV"
print_status "Deployment Type: $DEPLOY_TYPE"

chmod +x commons/scripts/dev-deploy.sh
#chmod +x gcp/dev-redeploy.sh
#chmod +x minikube/deploy.sh
#chmod +x minikube/redeploy.sh
#chmod +x gcp/prod-deploy.sh
#chmod +x gcp/prod-redeploy.sh

# Step 3: Execute Based on User Choice
if [[ "$ENV" == "dev" && "$DEPLOY_TYPE" == "Full Install" ]]; then
    print_status "Performing FULL INSTALL for DEV environment..."
    ./commons/scripts/dev-deploy.sh

elif [[ "$ENV" == "dev" && "$DEPLOY_TYPE" == "Service Redeploy" ]]; then
    print_status "Redeploying service in DEV environment..."
    ./commons/scripts/dev-redeploy.sh

elif [[ "$ENV" == "minikube" && "$DEPLOY_TYPE" == "Full Install" ]]; then
    print_status "Performing FULL INSTALL for MINIKUBE environment..."
    ./minikube/deploy.sh

elif [[ "$ENV" == "minikube" && "$DEPLOY_TYPE" == "Service Redeploy" ]]; then
    print_status "Redeploying service in MINIKUBE environment..."
    ./minikube/redeploy.sh

elif [[ "$ENV" == "prod" && "$DEPLOY_TYPE" == "Full Install" ]]; then
    print_status "Performing FULL INSTALL for PROD environment..."
    ./gcp/prod-deploy.sh

elif [[ "$ENV" == "prod" && "$DEPLOY_TYPE" == "Service Redeploy" ]]; then
    print_status "Redeploying service in PROD environment..."
    ./gcp/prod-redeploy.sh
else
    print_status "Invalid selection. Exiting."
    exit 1
fi

print_status "Deployment process completed!"
