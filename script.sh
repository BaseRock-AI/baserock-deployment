source ./commons/messaging.sh

print_status "Environment: $ENV"
print_status "Deployment Type: $DEPLOY_TYPE"
print_status "BASEROCK_CLOUD_OPTION_TYPE Type: $BASEROCK_CLOUD_OPTION_TYPE"
print_status "CERT_TYPE_OPTION Type: $CERT_TYPE_OPTION"
print_status "CERT_MANAGER_OPTION_TYPE Type: $CERT_MANAGER_OPTION_TYPE"
print_status "INGRESS_INSTALL_TYPE Type: $INGRESS_INSTALL_TYPE"
print_status "CERTIFICATE_OPTION_TYPE Type: $CERTIFICATE_OPTION_TYPE"

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
chmod +x commons/service-account/service-account.sh

./vars/"${ENV}-${BASEROCK_CLOUD_OPTION_TYPE}"-vars.sh
./vars/common-vars.sh

# Step 3: Execute Based on User Choice
if [[ "$BASEROCK_CLOUD_OPTION_TYPE" == "gcp" ]]; then
    print_status "Setting gcp context.."
    ./commons/gcp/set-cluster-context.sh

elif [[ "$BASEROCK_CLOUD_OPTION_TYPE" == "aws" ]]; then
    print_status "Setting aws context.."
    ./commons/aws/set-cluster-context.sh
fi


# Step 3: Execute Based on User Choice
if [[ "$DEPLOY_TYPE" == "Full Install" ]]; then
      print_status "Cleaning up.."
    ./commons/scripts/cleanup.sh
    ./commons/namespace-setup.sh
fi

if [[ "$CERT_MANAGER_OPTION_TYPE" != "Yes" && "$DEPLOY_TYPE" != "Full Install" && "$CERT_TYPE_OPTION" == "Self Signed" ]]; then
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

./commons/service-account/service-account.sh

kubectl get all -n ingress-nginx

print_status "Deployment process completed!"