#!/bin/bash

echo "`date` -- Sending metrics to Datadog host: $DOGSTATSD_HOST_IP"

while true; do
    readyNodes=$(kubectl get nodes -o json | jq -r '.items[] | select ( .status.conditions[] | select( .type=="Ready" and .status=="True")) | .metadata.name')
    notReadyNodes=$(kubectl get nodes -o json | jq -r '.items[] | select ( .status.conditions[] | select( .type=="Ready" and .status=="False")) | .metadata.name')

    # for each node in status=Ready, send:
    for node in $readyNodes; do
        echo "kubernetes.node_check:1|g|#status:Ready,node:$node" | nc -w 1 -u $DOGSTATSD_HOST_IP 8125
        echo "kubernetes.node_check:0|g|#status:NotReady,node:$node" | nc -w 1 -u $DOGSTATSD_HOST_IP 8125
    done

    # for each node in status=NotReady, send:
    for node in $notReadyNodes; do
        echo "kubernetes.node_check:1|g|#status:NotReady,node:$node" | nc -w 1 -u $DOGSTATSD_HOST_IP 8125
        echo "kubernetes.node_check:0|g|#status:Ready,node:$node" | nc -w 1 -u $DOGSTATSD_HOST_IP 8125
    done

    sleep 60;
done