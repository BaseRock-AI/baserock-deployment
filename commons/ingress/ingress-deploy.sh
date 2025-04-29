source ./commons/messaging.sh


helm repo add ingress-nginx https://kubernetes.github.io/ingress-nginx
helm repo update
kubectl delete ingressclass nginx -n ingress-nginx
helm uninstall nginx-ingress -n ingress-nginx
kubectl get all -n ingress-nginx | grep nginx
kubectl delete deployment,svc,configmap,ingressclass -n ingress-nginx -l app.kubernetes.io/name=ingress-nginx
kubectl delete namespace ingress-nginx 2>/dev/null || true

kubectl create namespace ingress-nginx


# Step 3: Apply the service YAML to expose the ingress-nginx-controller service
echo "Applying the ingress-nginx service"
kubectl apply -f https://raw.githubusercontent.com/kubernetes/ingress-nginx/controller-v1.6.4/deploy/static/provider/cloud/deploy.yaml

# Step 4: Patch the service to use the specific static IP
echo "Patching the service $INGRESS_SERVICE_NAME to use IP $IP_ADDRESS"
kubectl patch svc ingress-nginx-controller -n ingress-nginx --type='merge' -p "{\"spec\": {\"loadBalancerIP\": \"$STATIC_IP_ADDRESS\"}}"

sleep 60

envsubst < integration-testing/charts/ingress.yaml | kubectl apply -n "${NAMESPACE}" -f -

echo "Setup complete."
