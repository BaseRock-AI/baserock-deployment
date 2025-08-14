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

export ENV

while true; do
    echo "Internet Access to pull images:"
    echo "1) Yes"
    echo "2) No"
    read -p "#? " INTERNET_ACCESS_TYPE

    case $INTERNET_ACCESS_TYPE in
        1) INTERNET_ACCESS="Yes"; break;;
        2) INTERNET_ACCESS="No"; break;;
        *) echo "Invalid option. Please select again.";;
    esac
done

export INTERNET_ACCESS

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

export DEPLOY_TYPE

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

export CERT_TYPE_OPTION

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

export CERT_MANAGER_OPTION_TYPE

while true; do
    echo "Install certificate:"
    echo "1) Yes"
    echo "2) No"
    read -p "#? " CERTiFICATE_OPTION

    case $CERTiFICATE_OPTION in
        1) CERTIFICATE_OPTION_TYPE="Yes"; break;;
        2) CERTIFICATE_OPTION_TYPE="No"; break;;
        *) echo "Invalid option. Please select again.";;
    esac
done
export CERTIFICATE_OPTION_TYPE



while true; do
    echo "Install ingress:"
    echo "1) Yes"
    echo "2) No"
    read -p "#? " INGRESS_MANAGER_INSTALL_OPTION

    case $INGRESS_MANAGER_INSTALL_OPTION in
        1) INGRESS_INSTALL_TYPE="Yes"; break;;
        2) INGRESS_INSTALL_TYPE="No"; break;;
        *) echo "Invalid option. Please select again.";
    esac
done
export INGRESS_INSTALL_TYPE

while true; do
    echo "Ingress manager type:"
    echo "1) LoadBalancer"
    echo "2) NodePort"
    read -p "#? " INGRESS_MANAGER_OPTION

    case $INGRESS_MANAGER_OPTION in
        1) INGRESS_TYPE="LoadBalancer"; break;;
        2) INGRESS_TYPE="NodePort"; break;;
        *) echo "Invalid option. Please select again.";
    esac
done

export INGRESS_TYPE

while true; do
    echo "Deploy sample services:"
    echo "1) Yes"
    echo "2) No"
    read -p "#? " SAMPLE_SERVICES_OPTION

    case $SAMPLE_SERVICES_OPTION in
        1) SAMPLE_SERVICES_TYPE="Yes"; break;;
        2) SAMPLE_SERVICES_TYPE="No"; break;;
        *) echo "Invalid option. Please select again.";
    esac
done

export SAMPLE_SERVICES_TYPE

print_status "Environment: $ENV"
print_status "Deployment Type: $DEPLOY_TYPE"
print_status "BASEROCK_CLOUD_OPTION_TYPE Type: $BASEROCK_CLOUD_OPTION_TYPE"
print_status "CERT_TYPE_OPTION Type: $CERT_TYPE_OPTION"
print_status "CERT_MANAGER_OPTION_TYPE Type: $CERT_MANAGER_OPTION_TYPE"
print_status "INGRESS_TYPE Type: $INGRESS_TYPE"
print_status "INGRESS_INSTALL_TYPE Type: $INGRESS_INSTALL_TYPE"
print_status "CERTIFICATE_OPTION_TYPE Type: $CERTIFICATE_OPTION_TYPE"

export VARS_FILE="${ENV}-${BASEROCK_CLOUD_OPTION_TYPE}-vars.sh"
# shellcheck source=./commons/vars/dev-gcp-vars.sh
# shellcheck disable=SC1090
source ./vars/"$VARS_FILE"
source ./vars/common-vars.sh
source ./vars/image-vars.sh

printenv

chmod +x script.sh
./script.sh
