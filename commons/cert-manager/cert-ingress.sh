source ./commons/messaging.sh
envsubst < commons/cert-manager/ingress.yaml | kubectl apply -f -

sleep 5

print_status "kubectl apply -f commons/cert-manager/cert.yaml -n baserock-backend"
envsubst < commons/cert-manager/cert.yaml | kubectl apply -f -