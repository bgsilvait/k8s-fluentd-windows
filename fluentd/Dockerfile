
FROM mcr.microsoft.com/windows/servercore:ltsc2019 as base

# Do not split this into multiple RUN!
# Docker creates a layer for every RUN-Statement
RUN powershell -Command "Set-ExecutionPolicy Bypass -Scope Process -Force; iex ((New-Object System.Net.WebClient).DownloadString('https://chocolatey.org/install.ps1'))"

# Fluentd depends on cool.io whose fat gem is only available for Ruby < 2.5, so need to specify --platform ruby when install Ruby > 2.5 and install msys2 to get dev tools
# NOTE: For avoiding stalling with docker build on windows, we must use latest version of msys2.
RUN choco install -y ruby --version 2.7.2.1 --params "'/InstallDir:C:\ruby27'" \
&& choco install -y msys2 --version 20211130.0.0 --params "'/NoPath /NoUpdate /InstallDir:C:\ruby27\msys64'"
RUN refreshenv \
&& ridk install 3 \
&& echo gem: --no-document >> C:\ProgramData\gemrc \
&& gem install cool.io -v 1.5.4 --platform ruby \
&& gem install oj -v 3.3.10 \
&& gem install json -v 2.2.0 \
&& gem install fluentd -v 1.14.6 \
&& gem install win32-service -v 2.1.6 \
&& gem install win32-ipc -v 0.7.0 \
&& gem install win32-event -v 0.6.3 \
&& gem install windows-pr -v 1.2.6 \
&& gem install aws-sdk-cloudwatchlogs \
&& gem install fluent-plugin-concat \
&& gem install fluent-plugin-rewrite-tag-filter \
&& gem install fluent-plugin-multi-format-parser \
&& gem install fluent-plugin-cloudwatch-logs \
&& gem install fluent-plugin-kubernetes_metadata_filter \
&& gem sources --clear-all


FROM mcr.microsoft.com/windows/servercore:ltsc2019

COPY --from=base /ruby27 /ruby27

RUN setx /M PATH "C:\ruby27\bin;%PATH%"

CMD ["powershell", "-command", "fluentd"]