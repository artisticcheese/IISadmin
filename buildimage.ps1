#requires -Version 5
#Requires -RunAsAdministrator
param ([switch]$UploadDockerHub)
$hostName = "artisticcheese"
$tag = Get-date -Format "yyyyMMdd_HHmmss"
[Console]::OutputEncoding = [System.Text.Encoding]::Default
docker build . -t $hostName/iis-admin:$tag -t $hostName/iis-admin:latest
if ($? -and $UploadDockerHub)
{
    docker push $hostName/iis-admin:$tag
    docker push $hostName/iis-admin:latest
}

