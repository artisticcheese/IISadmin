# escape=`
FROM microsoft/windowsservercore:latest
SHELL ["powershell", "-Command", "$ErrorActionPreference = 'Stop'; $ProgressPreference = 'Continue'; $verbosePreference='Continue';"]
WORKDIR prep
ADD "http://go.microsoft.com/fwlink/?LinkId=829373" ".\iisadmin.exe"
COPY ["appsettings.json","C:\\Program Files\\IIS Administration\\2.0.0\\Microsoft.IIS.Administration\\config\\appsettings.json"]
RUN start-process -Filepath .\iisadmin.exe -ArgumentList  @('/install', '/q', '/norestart') -Wait 
ADD ["\\artifacts\\*", "./"]
COPY ["*.ps1", "creds.json", "c:\\startup\\"]
RUN .\server_config.ps1; .\website_config.ps1
COPY ["appsettings.json","api-keys.json", "C:\\Program Files\\IIS Administration\\2.0.0\\Microsoft.IIS.Administration\\config\\"]
EXPOSE 80 55539
ENTRYPOINT powershell.exe c:\startup\startup.ps1; powershell.exe C:\startup\entrypoint.ps1