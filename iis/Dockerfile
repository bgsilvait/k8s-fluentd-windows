FROM mcr.microsoft.com/windows/servercore/iis:windowsservercore-ltsc2019

#Set powershell as default shell
SHELL ["powershell", "-NoLogo", "-Command", "$ErrorActionPreference = 'Stop'; $ProgressPreference = 'SilentlyContinue';"]

#Add X-Forward-For Header to IIS Default website log
RUN Add-WebConfigurationProperty -pspath 'MACHINE/WEBROOT/APPHOST' -filter "system.applicationHost/sites/siteDefaults/logFile/customFields" -name "." "-value @{logFieldName='X-Forwarded-For';sourceName='X-Forwarded-For';sourceType='RequestHeader'}" 

#Add STDOUT LogMonitor binary and config in json format
COPY LogMonitor.exe LogMonitorConfig.json 'C:\LogMonitor\'
WORKDIR /LogMonitor

SHELL ["C:\\LogMonitor\\LogMonitor.exe", "powershell.exe"]
ENTRYPOINT C:\ServiceMonitor.exe w3svc;
