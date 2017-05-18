Param(
    [parameter(Mandatory=$true , Position=0)]
    [string]
    $Version
)

$administrators = New-Object System.Security.Principal.SecurityIdentifier([System.Security.Principal.WellKnownSidType]::BuiltinAdministratorsSid, $null)

$administratorsFullControl = New-Object System.Security.AccessControl.FileSystemAccessRule(
						$administrators, 
						[System.Security.AccessControl.FileSystemRights]::FullControl,
					    [System.Security.AccessControl.InheritanceFlags]::None, 
						[System.Security.AccessControl.PropagationFlags]::None,
						[System.Security.AccessControl.AccessControlType]::Allow)


# Enable Overwrite of web.config
$appPath = "C:\Program Files\IIS Administration\$version\Microsoft.IIS.Administration"
$cachedAppAcl = Get-Acl $appPath
$acl = Get-Acl $appPath
$acl.AddAccessRule($administratorsFullControl)
Set-Acl -Path $appPath -AclObject $acl;

$configPath = "C:\Program Files\IIS Administration\$Version\Microsoft.IIS.Administration\web.config"
$cachedConfigAcl = Get-Acl $configPath
$acl = Get-Acl $configPath
$acl.AddAccessRule($administratorsFullControl)
Set-Acl -Path $configPath -AclObject $acl;

Copy .\web.config $configPath

# Restore ACLs
Set-Acl -AclObject $cachedAppAcl -Path $appPath
Set-Acl -AclObject $cachedConfigAcl -Path $configPath