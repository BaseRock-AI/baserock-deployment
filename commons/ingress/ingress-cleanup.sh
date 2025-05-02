source ./commons/messaging.sh


helm repo add ingress-nginx https://kubernetes.github.io/ingress-nginx
helm repo update
kubectl delete ingressclass nginx -n ingress-nginx
helm uninstall nginx-ingress -n ingress-nginx
kubectl get all -n ingress-nginx | grep nginx
kubectl delete deployment,svc,configmap,ingressclass -n ingress-nginx -l app.kubernetes.io/name=ingress-nginx
kubectl delete namespace ingress-nginx 2>/dev/null || true
