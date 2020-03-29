#Taint Windows Server 1909 with os=Win1909
for i in $(kubectl get nodes -l beta.kubernetes.io/os=windows -o wide --no-headers | grep -w "Ready" | egrep -v SchedulingDisabled | grep -w "Windows Server Datacenter" | awk '{print $1}'); do date &&  kubectl taint nodes $i os=Win1909:NoSchedule --overwrite ; done

#Taint Windows Server 1809(Windows Server 2019/Ltcs 2019) with os=Win1809
for i in $(kubectl get nodes -l beta.kubernetes.io/os=windows -o wide --no-headers | grep -w "Ready" | egrep -v SchedulingDisabled | grep -w "Windows Server 2019 Datacenter" | awk '{print $1}'); do date &&  kubectl taint nodes $i os=Win1809:NoSchedule --overwrite ; done
