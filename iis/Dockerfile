FROM mcr.microsoft.com/windows/servercore/iis:windowsservercore-ltsc2019
#Set powershell as default shell
SHELL ["powershell", "-NoLogo", "-Command", "$ErrorActionPreference = 'Stop'; $ProgressPreference = 'SilentlyContinue';"]

#Install Chocolatey
RUN Set-ExecutionPolicy Bypass -Scope Process -Force; \
    iex ((New-Object System.Net.WebClient).DownloadString('https://chocolatey.org/install.ps1'))
#Install curl and vim
RUN choco install -y curl vim

#Add X-Forward-For Header to IIS Default website log | Adjust curl & grep
RUN Add-WebConfigurationProperty -pspath 'MACHINE/WEBROOT/APPHOST'  -filter "system.applicationHost/sites/siteDefaults/logFile/customFields" -name "." "-value @{logFieldName='X-Forwarded-For';sourceName='X-Forwarded-For';sourceType='RequestHeader'};" \
Add-Content -Path $PsHome\profile.ps1 -Value 'Remove-Item alias:curl -erroraction ignore'; \
Add-Content -Path $PsHome\profile.ps1 -Value 'new-alias grep findstr -erroraction ignore'

#Add STDOUT LogMonitor binari and config
COPY LogMonitor.exe LogMonitorConfig.json 'C:\LogMonitor\'
WORKDIR /LogMonitor

SHELL ["C:\\LogMonitor\\LogMonitor.exe", "powershell.exe"]
ENTRYPOINT C:\ServiceMonitor.exe w3svc;
