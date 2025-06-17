source ./commons/messaging.sh

# Step 3: Apply the service YAML to expose the ingress-nginx-controller service
echo "Applying the ingress-nginx service"
kubectl apply -f https://raw.githubusercontent.com/kubernetes/ingress-nginx/controller-v1.6.4/deploy/static/provider/cloud/deploy.yaml

# Step 4: Patch the service to use the specific static IP

if [[ "$STATIC_IP_ADDRESS" != "" && "$STATIC_IP_ADDRESS" != "<>" ]]; then
    echo "Patching the service $INGRESS_SERVICE_NAME to use IP $IP_ADDRESS"
    kubectl patch svc ingress-nginx-controller -n "${INGRESS_NAMESPACE}" --type='merge' -p "{\"spec\": {\"loadBalancerIP\": \"$STATIC_IP_ADDRESS\"}}"
fi

sleep 60

echo "Setup complete."
