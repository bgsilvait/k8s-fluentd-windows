# k8s-fluentd-windows
Stream Logs from K8s Windows Pods using Fluentd

before start:

1) EKS Cluster with Windows Nodes [doc/link]
2) OIDC configured[2]
(replace AWS_REGION and CLUSTERNAME with your config)

```
eksctl utils associate-iam-oidc-provider --region AWS_REGION --cluster CLUSTERNAME --approve
```

3) Windows Server 2019 w/ Docker for build your containers ( you can use the builded ones)

===

1) Create EKS Service account
/k8s
serviceaccount

```
eksctl create iamserviceaccount --cluster CLUSTERNAME \
--attach-policy-arn arn:aws:iam::aws:policy/CloudWatchFullAccess \
--name fluentd-windows --region AWS_REGION \
--namespace amazon-cloudwatch --approve
```

expected result:
```
kubectl get sa -n amazon-cloudwatch | grep fluentd-windows
fluentd-windows   1         
```

Apply the Daemonset 

(replace AWS_REGION and CLUSTERNAME with your config)


