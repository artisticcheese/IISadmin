# escape=`
FROM microsoft/iis
SHELL ["powershell", "-Command", "$ErrorActionPreference = 'Stop'; $ProgressPreference = 'Continue'; $verbosePreference='Continue';"]
#WORKDIR prep
ADD web.config .
RUN Write-Output "hello" 
#RUN powershell -Command Write-Output "hello"; Write-Output "hello again"
#RUN del .\*; del $env:temp\*
#COPY ["web.config","C:\\Program Files\\IIS Administration\\1.1.1\\Microsoft.IIS.Administration\\web.config"]
#COPY ["api-keys.json","C:\\Program Files\\IIS Administration\\1.1.1\\Microsoft.IIS.Administration\\config\\api-keys.json"]

#ENTRYPOINT powershell.exe .\startup.ps1; del .\startup.ps1; C:\ServiceMonitor.exe w3svc
