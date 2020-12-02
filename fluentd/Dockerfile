FROM mcr.microsoft.com/windows/servercore:ltsc2019 as base

#Set powershell as default shell
SHELL ["powershell", "-NoLogo", "-Command", "$ErrorActionPreference = 'Stop'; $ProgressPreference = 'SilentlyContinue';"]

#Install chocolatey package manager
RUN Set-ExecutionPolicy Bypass -Scope Process -Force; \
    iex ((New-Object System.Net.WebClient).DownloadString('https://chocolatey.org/install.ps1'))

#Install ruby and msys2 with chocolatey
RUN choco install -y ruby --version 2.6.5.1 --params "'/InstallDir:C:\ruby26'"; \
    choco install -y msys2 --params "'/NoPath /NoUpdate /InstallDir:C:\ruby26\msys64'"

#Install Ruby gems from fluentd Dockerfile + aws-sdk-cloudwatchlogs + Fluent plugins to parse and rewrite the logs
RUN refreshenv; \
ridk install 2 3; \
'gem: --no-document' | Out-File -Encoding UTF8 -NoNewline -Force -FilePath 'C:\ProgramData\gemrc'; \
gem install bundler; \
bundle config build.certstore_c --with-cflags="-Wno-attributes"; \
bundle config build.yajl-ruby --with-cflags="-Wno-attributes"; \
bundle config build.oj --with-cflags="-Wno-attributes"; \
gem install cool.io -v 1.5.4 --platform ruby; \
gem install oj -v 3.3.10; \
gem install json -v 2.2.0; \
gem install fluentd -v 1.11.5; \
gem install win32-service -v 1.0.1; \
gem install win32-ipc -v 0.7.0; \
gem install win32-event -v 0.6.3; \
gem install windows-pr -v 1.2.6; \
gem install aws-sdk-cloudwatchlogs; \
gem install fluent-plugin-concat; \
gem install fluent-plugin-rewrite-tag-filter; \
gem install fluent-plugin-multi-format-parser; \
gem install fluent-plugin-cloudwatch-logs; \
gem sources --clear-all; \
Remove-Item -Force C:\ruby26\lib\ruby\gems\2.6.0\cache\*.gem; \
Remove-Item -Recurse -Force C:\ProgramData\chocolatey

FROM mcr.microsoft.com/windows/servercore:ltsc2019

COPY --from=base /ruby26 /ruby26

RUN setx /M PATH ""C:\ruby26\bin;%PATH%"

CMD ["powershell", "-command", "fluentd"]
