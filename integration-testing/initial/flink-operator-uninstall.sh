kubectl delete deployment "${FLINK_JOB_NAME}" -n "${NAMESPACE}"
helm uninstall flink-kubernetes-operator -n "${NAMESPACE}"
kubectl delete clusterrole flink-operator
kubectl delete clusterrolebinding flink-operator-role-binding
kubectl delete validatingwebhookconfigurations "flink-operator-${NAMESPACE}-webhook-configuration" -n onpremise-baserock
kubectl delete mutatingwebhookconfigurations "flink-operator-${NAMESPACE}-webhook-configuration" -n onpremise-baserock

kubectl patch flinkdeployments.flink.apache.org flink-aggregation-job  -n onpremise-baserock \
  --type=json \
  -p='[{"op": "remove", "path": "/metadata/finalizers"}]'