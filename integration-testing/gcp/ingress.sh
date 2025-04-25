source ./commons/messaging.sh

CONTEXT="gke_${PROJECT_ID}_${GKE_REGION}_${GKE_CLUSTER}"
kubectl config use-context $CONTEXT

helm repo add "${INGRESS_NAMESPACE}" https://kubernetes.github.io/ingress-nginx
helm repo update
kubectl delete ingressclass nginx -n "${INGRESS_NAMESPACE}"
kubectl get all -n "${INGRESS_NAMESPACE}" | grep nginx
kubectl delete deployment,svc,configmap,ingressclass -n "${INGRESS_NAMESPACE}" -l app.kubernetes.io/name=ingress-nginx
kubectl delete namespace "${INGRESS_NAMESPACE}" 2>/dev/null || true
kubectl delete clusterrolebinding cluster-admin-binding

kubectl create namespace "${INGRESS_NAMESPACE}"

# Step 3: Apply the service YAML to expose the ingress-nginx-controller service
echo "Applying the ingress-nginx service"
kubectl apply -f https://raw.githubusercontent.com/kubernetes/ingress-nginx/controller-v1.6.4/deploy/static/provider/cloud/deploy.yaml -n "${INGRESS_NAMESPACE}"

# Step 4: Patch the service to use the specific static IP
echo "Patching the service $INGRESS_SERVICE_NAME to use IP $IP_ADDRESS"
kubectl patch svc ingress-nginx-controller -n "${INGRESS_NAMESPACE}" --type='merge' -p "{\"spec\": {\"loadBalancerIP\": \"$STATIC_IP_ADDRESS\"}}"

sleep 60

envsubst < charts/ingress.yaml | kubectl apply -n "${NAMESPACE}" -f -

echo "Setup complete."
