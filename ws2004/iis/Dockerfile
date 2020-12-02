FROM mcr.microsoft.com/windows/servercore/iis:windowsservercore-2004

#Set powershell as default shell and SilentlyContinue as using $env:
SHELL ["powershell", "-NoLogo", "-Command", "$ErrorActionPreference = 'Stop'; $ProgressPreference = 'SilentlyContinue';"]

#Add powerash project && custom-iis(needs to be invoqued after container starts)
#for i in $(kubectl get pods -l run=winiis -o wide --no-headers | grep -w "Running"| awk '{print $1}'); do date && kubectl exec $i powershell /custom-iis.ps1 ; done
RUN iwr -o powerash.ps1 https://raw.githubusercontent.com/bgsilvait/powerash/master/powerash.ps1 ; \
.\powerash.ps1 ; \
iwr -o custom-iis.ps1 https://raw.githubusercontent.com/bgsilvait/powerash/master/custom-iis.ps1 

#Add STDOUT LogMonitor binary and config in json format
COPY LogMonitor.exe LogMonitorConfig.json 'C:\LogMonitor\'
WORKDIR /LogMonitor

SHELL ["C:\\LogMonitor\\LogMonitor.exe", "powershell.exe"]
ENTRYPOINT C:\ServiceMonitor.exe w3svc;
