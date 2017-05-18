#requires -Version 5
#Requires -RunAsAdministrator

param ([switch]$UploadDockerHub)
$hostName = "artisticcheese"
$tag = Get-date -Format "yyyyMMdd_HHmmss"
[Console]::OutputEncoding = [System.Text.Encoding]::Default
docker build . -t $hostName/iis-basis:$tag -t $hostName/iis-basis:latest
if ($? -and $UploadDockerHub) {
    docker push $hostName/iis-basis:$tag
    docker push $hostName/iis-basis:latest
}

