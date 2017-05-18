Configuration SecondStep 
{
    Import-DSCResource -moduleName "xPSDesiredStateConfiguration"
    xRemoteFile IISadmin {
        Destinationpath = "c:\prep\iisadmin.exe"
        URI             = "http://go.microsoft.com/fwlink/?LinkId=829373"
    }
    xPackage DotNetCore {
        Name      = "IISadmin"
        path      = "c:\prep\iisadmin.exe"
        ProductId = ""
        Ensure    = "Present"
        Arguments = '/install /q /norestart'
        DependsOn = "[xRemoteFile]IISadmin"
    }
    
}
SecondStep -OutputPath .\BasicIIS
Start-DscConfiguration -Wait -Verbose -Path .\BasicIIS -Force
remove-item .\basicIIS -Force -Recurse
