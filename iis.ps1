#Add X-Forward-For IIS Default website
Add-WebConfigurationProperty -pspath 'MACHINE/WEBROOT/APPHOST'  -filter "system.applicationHost/sites/siteDefaults/logFile/customFields" -name "." -value @{logFieldName='X-Forwarded-For'
;sourceName='X-Forwarded-For';sourceType='RequestHeader'}
