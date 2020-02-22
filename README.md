# k8s-fluentd-windows
Stream Logs from K8s Windows Pods using Fluentd

before start:

1) EKS Cluster with Windows Nodes [doc/link]
2) OIDC configured[2]
3) Windows Server 2019 w/ Docker for build your containers ( you can use the builded ones)

===

1) Create EKS Service account
-> cd /k8s ( change the cluster name and aws region)
