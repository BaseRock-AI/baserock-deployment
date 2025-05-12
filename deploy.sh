#!/bin/bash

source ./commons/messaging.sh

require_command() {
  command -v "$1" >/dev/null 2>&1 || { echo "$1 is required but not installed."; exit 1; }
}

require_command docker
require_command kubectl
require_command helm
require_command dig


# Step 2: Select Deployment Type
while true; do
    echo "Select cloud env:"
    echo "1) gcp"
    echo "2) aws"
    echo "3) minikube"
    read -p "#? " BASEROCK_CLOUD_OPTION

    case $BASEROCK_CLOUD_OPTION in
        1) BASEROCK_CLOUD_OPTION_TYPE="gcp"; break;;
        2) BASEROCK_CLOUD_OPTION_TYPE="aws"; break;;
        3) BASEROCK_CLOUD_OPTION_TYPE="minikube"; break;;
        *) echo "Invalid option. Please select again.";;
    esac
done

export BASEROCK_CLOUD_OPTION_TYPE


while true; do
    echo "Select Environment:"
    echo "1) minikube"
    echo "2) dev"
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


while true; do
    echo "Certificate Type:"
    echo "1) Self Signed"
    echo "2) Cloud Based"
    read -p "#? " CERT_TYPE

    case $CERT_TYPE in
        1) CERT_TYPE_OPTION="Self Signed"; break;;
        2) CERT_TYPE_OPTION="Cloud"; break;;
        *) echo "Invalid option. Please select again.";;
    esac
done

while true; do
    echo "Install cert manager:"
    echo "1) Yes"
    echo "2) No"
    read -p "#? " CERT_MANAGER_OPTION

    case $CERT_MANAGER_OPTION in
        1) CERT_MANAGER_OPTION_TYPE="Yes"; break;;
        2) CERT_MANAGER_OPTION_TYPE="No"; break;;
        *) echo "Invalid option. Please select again.";;
    esac
done

print_status "Environment: $ENV"
print_status "Deployment Type: $DEPLOY_TYPE"
print_status "BASEROCK_CLOUD_OPTION_TYPE Type: $BASEROCK_CLOUD_OPTION_TYPE"
print_status "CERT_TYPE_OPTION Type: $CERT_TYPE_OPTION"
print_status "CERT_MANAGER_OPTION_TYPE Type: $CERT_MANAGER_OPTION_TYPE"


# shellcheck source=./commons/vars/dev-gcp-vars.sh
source ./vars/"${ENV}-${BASEROCK_CLOUD_OPTION_TYPE}"-vars.sh
source ./vars/common-vars.sh


chmod +x commons/scripts/install-with-cert.sh
chmod +x commons/scripts/install-without-cert.sh
chmod +x commons/scripts/common-backend-deploy.sh
chmod +x commons/scripts/common-backend-redeploy.sh
chmod +x commons/aws/set-cluster-context.sh
chmod +x commons/gcp/set-cluster-context.sh
chmod +x commons/scripts/cleanup.sh
chmod +x commons/image-secret.sh
chmod +x vars/"${ENV}-${BASEROCK_CLOUD_OPTION_TYPE}"-vars.sh
chmod +x vars/common-vars.sh
chmod +x commons/image-secret.sh
chmod +x commons/scripts/install-with-self-signed-cert.sh

./vars/"${ENV}-${BASEROCK_CLOUD_OPTION_TYPE}"-vars.sh
./vars/common-vars.sh

# Step 3: Execute Based on User Choice
if [[ "$BASEROCK_CLOUD_OPTION_TYPE" == "gcp" ]]; then
    print_status "Setting gcp context.."
    ./commons/gcp/set-cluster-context.sh

elif [[ "$BASEROCK_CLOUD_OPTION_TYPE" == "aws" ]]; then
    print_status "Setting aws context.."
    ./commons/aws/set-cluster-context.sh

elif [[ "$BASEROCK_CLOUD_OPTION_TYPE" == "minikube" ]]; then
    print_status "Setting minikube context.."
    ./minikube/minikube-install.sh
fi


# Step 3: Execute Based on User Choice
if [[ "$DEPLOY_TYPE" == "Full Install" ]]; then
      print_status "Cleaning up.."
    ./commons/scripts/cleanup.sh
    ./commons/namespace-setup.sh
fi

if [[ "$DEPLOY_TYPE" != "Full Install" && "$CERT_TYPE_OPTION" == "Self Signed" ]]; then
      print_status "Cleaning up cert manager for self signed certificate.."
    ./commons/cert-manager/cert-manager-cleanup.sh
fi

if [ -n "$IMAGE_PULL_SECRET" ]; then
  export IMAGE_PULL_SECRET_BLOCK="imagePullSecrets: [{ name: $IMAGE_PULL_SECRET }]"
else
  export IMAGE_PULL_SECRET_BLOCK=""
fi

if [[ "$BASEROCK_CLOUD_OPTION_TYPE" == "aws" ]]; then
  export STORAGE_CLASS_BLOCK="gp2"
elif [[ "$BASEROCK_CLOUD_OPTION_TYPE" == "gcp" ]]; then
  export STORAGE_CLASS_BLOCK="standard"
else
  export STORAGE_CLASS_BLOCK=""
fi

echo "${IMAGE_PULL_SECRET_BLOCK}"
echo "storageClassName:${STORAGE_CLASS_BLOCK}"


# Step 3: Execute Based on User Choice
if [[ "$IMAGE_PULL_SECRET" != "" ]]; then
    ./commons/image-secret.sh
fi



# Step 3: Execute Based on User Choice
if [[ "$CERT_MANAGER_OPTION_TYPE" == "Yes" &&  "$DEPLOY_TYPE" == "Full Install" && "$CERT_TYPE_OPTION" != "Self Signed" ]]; then
    print_status "Installing with cert-manager in cluster"
    ./commons/scripts/install-with-cert.sh

elif [[ "$CERT_MANAGER_OPTION_TYPE" == "No" &&  "$DEPLOY_TYPE" == "Full Install" && "$CERT_TYPE_OPTION" != "Self Signed" ]]; then
    print_status "Installing without cert-manager in cluster"
    ./commons/scripts/install-without-cert.sh

elif [[ "$CERT_TYPE_OPTION" == "Self Signed" &&  "$DEPLOY_TYPE" == "Full Install" ]]; then
    print_status "Self Signed certificate deployment..."
    ./commons/scripts/install-with-self-signed-cert.sh

fi


if [[ "$DEPLOY_TYPE" == "Full Install" ]]; then
    print_status "Performing FULL INSTALL for DEV environment..."
    ./commons/scripts/common-backend-deploy.sh

elif [[ "$DEPLOY_TYPE" == "Service Redeploy" ]]; then
    print_status "Redeploying service in DEV environment..."
    ./commons/scripts/common-backend-redeploy.sh
fi

print_status "Deployment process completed!"
