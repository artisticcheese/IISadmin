# escape=`
FROM microsoft/iis
SHELL ["powershell", "-Command", "$ErrorActionPreference = 'Stop'; $ProgressPreference = 'Continue'; $verbosePreference='Continue';"]
WORKDIR prep
ADD server_config.ps1 .\server_config.ps1
ADD startup.ps1 .\startup.ps1
ADD https://github.com/Microsoft/IIS.Administration/releases/download/v2.0.0/IISAdministrationSetup.exe .\iisadmin.exe
COPY ["appsettings.json","C:\\Program Files\\IIS Administration\\2.0.0\\Microsoft.IIS.Administration\\config\\appsettings.json"]
RUN start-process -Filepath .\iisadmin.exe -ArgumentList  @('/install', '/q', '/norestart') -Wait 
RUN .\server_config.ps1; del .\server_config.ps1; del .\iisadmin.exe;
COPY ["appsettings.json","C:\\Program Files\\IIS Administration\\2.0.0\\Microsoft.IIS.Administration\\config\\appsettings.json"]
COPY ["api-keys.json","C:\\Program Files\\IIS Administration\\2.0.0\\Microsoft.IIS.Administration\\config\\api-keys.json"]
EXPOSE 80 55539
ENTRYPOINT powershell.exe .\startup.ps1; del .\startup.ps1; C:\ServiceMonitor.exe w3svc
