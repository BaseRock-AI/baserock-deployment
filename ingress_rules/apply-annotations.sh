#!/bin/bash
# Apply annotations to all Ingresses in a namespace

# ---- Configure environment variables ----
# ---- Fetch all ingress names in the namespace ----
INGRESS_NAMES=$(kubectl get ingress -n "${NAMESPACE}" -o jsonpath='{.items[*].metadata.name}')

if [ -z "$INGRESS_NAMES" ]; then
  echo "No ingress resources found in namespace $NAMESPACE"
  exit 0
fi

# ---- Loop through each ingress and apply annotations ----
for NAME in $INGRESS_NAMES; do
  echo "Applying annotations to ingress: $NAME"

  kubectl annotate ingress "$NAME" -n "$NAMESPACE" \
    kubernetes.io/ingress.class="$INGRESS_CLASS" \
    nginx.ingress.kubernetes.io/proxy-connect-timeout="300" \
    nginx.ingress.kubernetes.io/proxy-read-timeout="300" \
    nginx.ingress.kubernetes.io/proxy-send-timeout="300" \
    cert-manager.io/issuer="$ISSUER_NAME" \
    --overwrite

  if [[ "$NAME" == "le-service-ingress" || "$NAME" == "le-django-service-ingress" ]]; then
    kubectl annotate ingress "$NAME" -n "$NAMESPACE" \
      nginx.ingress.kubernetes.io/force-ssl-redirect="true" \
      nginx.ingress.kubernetes.io/use-regex="true" \
      nginx.ingress.kubernetes.io/rewrite-target="/\$1" \
      --overwrite
  fi

done

echo "Annotations applied to all ingresses in namespace $NAMESPACE"
