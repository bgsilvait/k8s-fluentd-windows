 #Requires -Version 5.0
$ErrorActionPreference = "Stop"

# remove old Gemfile.lock
Remove-Item -Force -Path 'C:\fluentd\install\Gemfile.lock';

# generate new Gemfile.lock
cd 'C:\fluentd\install\'
bundle install

$null = Copy-Item -Force -Path 'C:\fluentd\install\Gemfile.lock' -Destination 'C:\gems\Gemfile.lock' 
