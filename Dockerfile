# escape=`
FROM microsoft/iis
SHELL ["powershell", "-Command", "$ErrorActionPreference = 'Stop'; $ProgressPreference = 'Continue'; $verbosePreference='Continue';"]
WORKDIR prep
ADD server_config.ps1 .\server_config.ps1
ADD startup.ps1 .\startup.ps1
ADD http://go.microsoft.com/fwlink/?LinkId=829373 .\iisadmin.exe
RUN .\iisadmin.exe /install /q /norestart ;.\server_config.ps1;  del .\server_config.ps1; 
COPY ["api-keys.json","C:\\Program Files\\IIS Administration\\1.1.1\\Microsoft.IIS.Administration\\config\\api-keys.json"]
EXPOSE 80 55539
ENTRYPOINT powershell.exe .\startup.ps1; del .\startup.ps1; C:\ServiceMonitor.exe w3svc
