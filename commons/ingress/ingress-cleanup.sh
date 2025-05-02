source ./commons/messaging.sh

kubectl delete ingressclass nginx -n ingress-nginx
kubectl get all -n ingress-nginx | grep nginx
kubectl delete deployment,svc,configmap,ingressclass -n ingress-nginx -l app.kubernetes.io/name=ingress-nginx
kubectl delete namespace "${INGRESS_NAMESPACE}" 2>/dev/null || true
