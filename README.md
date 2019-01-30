# k8s-node-check

This script checks the status of Kubernetes nodes and sends it to Datadog.

### Requirements
The Datadog agent must be deployed on each node of the cluster and listening on UDP port 8125.

See: https://docs.datadoghq.com/agent/kubernetes/dogstatsd/ for more info.

### ENV variables
- `DOGSTATSD_HOST_IP`: This is the IP of the host on which the pod runs.