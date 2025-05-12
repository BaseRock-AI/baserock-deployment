#!/bin/bash

kubectl delete job upcaster-deployment-cronjob -n "${NAMESPACE}"
kubectl apply -f charts/batch-upcaster.yaml