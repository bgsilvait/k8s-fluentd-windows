FROM mcr.microsoft.com/windows/servercore/iis:windowsservercore-ltsc2019

#Install Chocolatey
RUN Set-ExecutionPolicy Bypass -Scope Process -Force; \
    iex ((New-Object System.Net.WebClient).DownloadString('https://chocolatey.org/install.ps1'))
#Install curl and vim
RUN choco install -y curl vim

#Add X-Forward-For to IIS Default website log
RUN Add-WebConfigurationProperty -pspath 'MACHINE/WEBROOT/APPHOST'  -filter "system.applicationHost/sites/siteDefaults/logFile/customFields" -name "." -value @{logFieldName='X-Forwarded-For'
;sourceName='X-Forwarded-For';sourceType='RequestHeader'}; \
#Refresh env | adjust curl & grep
Add-Content -Path $PsHome\profile.ps1 -Value '$env:Path = [System.Environment]::GetEnvironmentVariable("Path","Machine") + ";" + [System.Environment]::GetEnvironmentVariable("Path","User")'; \
Add-Content -Path $PsHome\profile.ps1 -Value 'Remove-Item alias:curl -erroraction ignore'; \
Add-Content -Path $PsHome\profile.ps1 -Value 'new-alias grep findstr -erroraction ignore'
#Add STDOUT binaries
COPY LogMonitor.exe LogMonitorConfig.json C:\LogMonitor\

WORKDIR /LogMonitor

SHELL ["C:\\LogMonitor\\LogMonitor.exe", "powershell.exe"]

ENTRYPOINT C:\ServiceMonitor.exe w3svc;
