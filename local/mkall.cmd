powershell -ExecutionPolicy Bypass %~dp0\..\load-podofo.ps1  
powershell -ExecutionPolicy Bypass %~dp0\..\load-libraries.ps1 zlib %1 %2
powershell -ExecutionPolicy Bypass %~dp0\..\load-libraries.ps1 libpng %1 %2
