FROM mcr.microsoft.com/windows/servercore:ltsc2019

SHELL ["powershell", "-NoLogo", "-Command", "$ErrorActionPreference = 'Stop'; $ProgressPreference = 'SilentlyContinue';"]

RUN Set-ExecutionPolicy Bypass -Scope Process -Force; \
    iex ((New-Object System.Net.WebClient).DownloadString('https://chocolatey.org/install.ps1'))

RUN choco install -y ruby --version 2.4.2.2 --params "'/InstallDir:C:\'"; \
    choco install -y msys2 --params "'/NoPath /NoUpdate /InstallDir:C:\ruby24\msys64'"

COPY Gemfile 'C:\fluentd\install\Gemfile'

RUN refreshenv; \
ridk install 2 3; \
'gem: --no-document' | Out-File -Encoding UTF8 -NoNewline -Force -FilePath 'C:\ProgramData\gemrc'; \
gem install bundler; \
bundle config build.certstore_c --with-cflags="-Wno-attributes"; \
bundle config build.yajl-ruby --with-cflags="-Wno-attributes"; \
bundle config build.oj --with-cflags="-Wno-attributes"; \
bundle install --gemfile='C:\fluentd\install\Gemfile'; \
gem sources --clear-all; \
Remove-Item -Force C:\ruby24\lib\ruby\gems\2.4.0\cache\*.gem; \
Remove-Item -Recurse -Force C:\ProgramData\chocolatey

COPY upgrade-gems.ps1 'C:\fluentd\install\upgrade-gems.ps1'
COPY fluent.conf 'C:\etc\fluent\fluent.conf'
COPY containers.conf 'C:\etc\fluent\config.d\containers.conf'

CMD ["powershell", "-command", "fluentd"]
