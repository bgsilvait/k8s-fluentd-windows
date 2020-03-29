#Exec powershell /custom-iis.ps1 in all pods with label run=winiis
for i in $(kubectl get pods -l run=winiis -o wide --no-headers | grep -w "Running"| awk '{print $1}'); do date && kubectl exec $i powershell /custom-iis.ps1 ; done
