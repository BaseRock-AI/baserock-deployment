#!/bin/bash

source ./commons/messaging.sh

# Defaults
if [[ "$INGRESS_INSTALL_TYPE" == "Yes" ]]; then
  INGRESS_SERVICE_NAME=ingress-nginx-controller

  echo "Applying the ingress-nginx controller manifests..."
  envsubst < commons/ingress/ingress-controller.yaml | kubectl apply -f -
  echo "Waiting for the ingress-nginx-controller service to be created..."
  sleep 30
fi


if [[ "$INGRESS_INSTALL_TYPE" == "Yes" && "$INGRESS_TYPE" == "LoadBalancer" ]]; then
    echo "Ingress type is LoadBalancer"

    if [[ -n "$STATIC_IP_ADDRESS" && "$STATIC_IP_ADDRESS" != "<>" ]]; then
        echo "Patching the service $INGRESS_SERVICE_NAME to use static IP $STATIC_IP_ADDRESS"
        kubectl patch svc "$INGRESS_SERVICE_NAME" -n "$INGRESS_NAMESPACE" --type='merge' \
            -p "{\"spec\": {\"type\": \"LoadBalancer\", \"loadBalancerIP\": \"$STATIC_IP_ADDRESS\"}}"
    elif [[ -n "$EIP_ALLOCATION_ID" && "$EIP_ALLOCATION_ID" != "<>" ]]; then
        echo "Patching the service $INGRESS_SERVICE_NAME to use Elastic IP allocation ID $EIP_ALLOCATION_ID"
        kubectl patch svc "$INGRESS_SERVICE_NAME" -n "$INGRESS_NAMESPACE" \
          -p "{
            \"metadata\": {
              \"annotations\": {
                \"service.beta.kubernetes.io/aws-load-balancer-type\": \"nlb\",
                \"service.beta.kubernetes.io/aws-load-balancer-scheme\": \"internet-facing\",
                \"service.beta.kubernetes.io/aws-load-balancer-name\": \"$AWS_NLB_NAME\",
                \"service.beta.kubernetes.io/aws-load-balancer-eip-allocations\": \"$EIP_ALLOCATION_ID\"
              }
            },
            \"spec\": {
              \"type\": \"LoadBalancer\"
            }
          }"
    else
        echo "No static IP provided. Using default LoadBalancer provisioning."
        kubectl patch svc "$INGRESS_SERVICE_NAME" -n "$INGRESS_NAMESPACE" --type='merge' \
            -p "{\"spec\": {\"type\": \"LoadBalancer\"}}"
    fi

elif [[ "$INGRESS_INSTALL_TYPE" == "Yes" && "$INGRESS_TYPE" == "NodePort" ]]; then
    echo "Ingress type is NodePort"

    echo "Patching ingress controller to NodePort mode with ports 30080 and 30443"
    kubectl patch svc $INGRESS_SERVICE_NAME -n "$INGRESS_NAMESPACE" \
      --type='merge' \
      -p "{
        \"spec\": {
          \"type\": \"NodePort\",
          \"ports\": [
            {
              \"name\": \"http\",
              \"port\": 80,
              \"protocol\": \"TCP\",
              \"targetPort\": 80,
              \"nodePort\": 30080
            },
            {
              \"name\": \"https\",
              \"port\": 443,
              \"protocol\": \"TCP\",
              \"targetPort\": 443,
              \"nodePort\": 30443
            }
          ]
        }
      }"

elif [[ "$INGRESS_INSTALL_TYPE" == "Yes" ]]; then
    echo "Invalid INGRESS_TYPE value: $INGRESS_TYPE. Must be 'LoadBalancer' or 'NodePort'."
fi

if [[ "$INGRESS_INSTALL_TYPE" == "Yes" ]]; then
  echo "Waiting for configuration to take effect..."
  sleep 60

  kubectl get svc "$INGRESS_SERVICE_NAME" -n "$INGRESS_NAMESPACE"

  echo "Ingress setup complete."
fi

