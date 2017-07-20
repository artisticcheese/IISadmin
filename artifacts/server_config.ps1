Configuration BasicIIS
{
    Import-DscResource -ModuleName 'PSDesiredStateConfiguration' 
    node localhost {
        WindowsFeature Web-Server
        {
            Name ="Web-Server"
            Ensure="Present"
        }
        WindowsFeature IIS
        {
            Ensure = "Present"
            Name = "Web-Mgmt-Service"
        }
        WindowsFeature Init
        {
            Name = "Web-AppInit" 
            Ensure = "Present"
            IncludeAllSubFeature = $true
        }
        WindowsFeature Web-Http-Tracing
        {
            Ensure = "Present"
            Name = "Web-Http-Tracing"
        } 
        WindowsFeature Web-Http-Logging
        {
            Ensure = "Present"
            Name = 'Web-Http-Logging'
        }
        WindowsFeature         Web-Windows-Auth
        {
            Ensure = "Present"
            Name = 'Web-Windows-Auth'
        }
        WindowsFeature Web-Request-Monitor
        {
            Ensure = "Present"
            Name = "Web-Request-Monitor"
        } 
        WindowsFeature StaticContent
        {
            Ensure = "Present"
            Name = 'Web-Static-Content'
        }
        Service WebManagementService
        {    
            Name = "WMSVC"
            StartupType = "Automatic"
            State = "Running"
            DependsOn = "[WindowsFeature]IIS"
        }
        Registry RemoteManagement
        {
            Key = "HKLM:\SOFTWARE\Microsoft\WebManagement\Server"
            ValueName = "EnableRemoteManagement"
            ValueData = 1
            ValueType = "Dword"
            DependsOn = "[WindowsFeature]IIS"
        }
        Registry HTTPErrSize
        {
            Ensure = "Present"
            Key = "HKLM:\System\CurrentControlSet\Services\HTTP\Parameters"
            ValueName = "ErrorLogFileTruncateSize"
            ValueType = "DWORD"
            ValueData = "1000000"
        }
        Registry HTTPErrLocation
        {
            Ensure = "Present"
            Key = "HKLM:\System\CurrentControlSet\Services\HTTP\Parameters"
            ValueName = "ErrorLoggingDir"
            ValueType = "String"
            ValueData = "%systemroot%\inetpub\logs\host\httperr"
        }
    }
}

Install-PackageProvider -Name NuGet -MinimumVersion 2.8.5.201 -Force
Install-Module -Name xWebAdministration -Force -Verbose -Repository PSGallery -SkipPublisherCheck
Install-Module -Name xPSDesiredStateConfiguration -Verbose -Repository PSGallery -Force
BasicIIS -OutputPath .\BasicIIS
Start-DscConfiguration -Wait -Verbose -Path .\BasicIIS -Force


