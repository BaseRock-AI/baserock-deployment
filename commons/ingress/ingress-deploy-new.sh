#!/bin/bash

source ./commons/messaging.sh

# Defaults
INGRESS_SERVICE_NAME=ingress-nginx-controller

echo "Applying the ingress-nginx controller manifests..."
kubectl apply -f https://raw.githubusercontent.com/kubernetes/ingress-nginx/controller-v1.6.4/deploy/static/provider/cloud/deploy.yaml

echo "Waiting for the ingress-nginx-controller service to be created..."
sleep 30

if [[ "$INGRESS_TYPE" == "LoadBalancer" ]]; then
    echo "Ingress type is LoadBalancer"

    if [[ -n "$STATIC_IP_ADDRESS" && "$STATIC_IP_ADDRESS" != "<>" ]]; then
        echo "Patching the service $INGRESS_SERVICE_NAME to use static IP $STATIC_IP_ADDRESS"
        kubectl patch svc "$INGRESS_SERVICE_NAME" -n "$INGRESS_NAMESPACE" --type='merge' \
            -p "{\"spec\": {\"type\": \"LoadBalancer\", \"loadBalancerIP\": \"$STATIC_IP_ADDRESS\"}}"
    else
        echo "No static IP provided. Using default LoadBalancer provisioning."
        kubectl patch svc "$INGRESS_SERVICE_NAME" -n "$INGRESS_NAMESPACE" --type='merge' \
            -p "{\"spec\": {\"type\": \"LoadBalancer\"}}"
    fi

elif [[ "$INGRESS_TYPE" == "NodePort" ]]; then
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

else
    echo "Invalid INGRESS_TYPE value: $INGRESS_TYPE. Must be 'LoadBalancer' or 'NodePort'."
    exit 1
fi

echo "Waiting for configuration to take effect..."
sleep 60

kubectl get svc "$INGRESS_SERVICE_NAME" -n "$INGRESS_NAMESPACE"

echo "Ingress setup complete."
