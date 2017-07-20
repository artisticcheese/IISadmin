Configuration BasicIIS
 {
    Import-DscResource -ModuleName 'PSDesiredStateConfiguration' 
    node localhost {
        WindowsFeature Web-Server
        {
            Name ="Web-Server"
            Ensure="Present"
        }
        WindowsFeature IIS {
            Ensure = "Present"
            Name = "Web-Mgmt-Service"
        }
        WindowsFeature         Web-Windows-Auth {
            Ensure = "Present"
            Name = 'Web-Windows-Auth'
        }
        Service WebManagementService {    
            Name = "WMSVC"
            StartupType = "Automatic"
            State = "Running"
            DependsOn = "[WindowsFeature]IIS"
        }
        Registry RemoteManagement {
            Key = "HKLM:\SOFTWARE\Microsoft\WebManagement\Server"
            ValueName = "EnableRemoteManagement"
            ValueData = 1
            ValueType = "Dword"
            DependsOn = "[WindowsFeature]IIS"
        }
    }
}

BasicIIS -OutputPath .\BasicIIS
Start-DscConfiguration -Wait -Verbose -Path .\BasicIIS -Force
remove-item .\basicIIS -Force -Recurse



