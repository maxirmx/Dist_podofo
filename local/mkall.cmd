powershell -ExecutionPolicy Bypass %~dp0\..\load-podofo.ps1  
powershell -ExecutionPolicy Bypass %~dp0\..\load-library.ps1 zlib %1 %2
powershell -ExecutionPolicy Bypass %~dp0\..\load-library.ps1 libpng %1 %2
