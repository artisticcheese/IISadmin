Configuration SecondStep 
{
    Import-DSCResource -moduleName "xWebAdministration", "xPSDesiredStateConfiguration"
    xWebSiteDefaults DefaultConfig {
        ApplyTo = "Machine"
        LogDirectory = "c:\inetpub\logs\LogFiles\host"
        TraceLogDirectory = "c:\inetpub\logs\LogFiles\freb"
    }
    xIISLogging DefaultIISLOg {
        LogPath = "c:\inetpub\logs\LogFiles\host"
        LogFlags = "Date", "Time" , "ClientIP", "UserName", "SiteName", "ComputerName", "ServerIP", "Method", "UriStem", "UriQuery", "HttpStatus", "Win32Status", "BytesSent", "BytesRecv", "TimeTaken", "ServerPort", "UserAgent", "Cookie", "Referer", "ProtocolVersion", "Host", "HttpSubStatus"
        LogPeriod = 'Daily'
    }
    
}
Import-module WebAdministration
$splat = @{
    "pspath" = "MACHINE/WEBROOT/APPHOST"
    "filter" = "system.applicationHost/sites/siteDefaults/logFile"
    "Name" =  "logTargetW3C"
    "Value" = "File,ETW"
}
Set-WebConfigurationProperty @splat
$IISOpsLog = Get-WinEvent -ListLog Microsoft-IIS-Logging/logs
$IISOpsLog.IsEnabled = "true"
$IISOpsLog.SaveChanges()
SecondStep -OutputPath .\BasicIIS 
Start-DscConfiguration -Wait -Verbose -Path .\BasicIIS -Force
remove-item .\* -Force -Recurse
remove-item $env:temp\* -Recurse -ErrorAction Ignore
