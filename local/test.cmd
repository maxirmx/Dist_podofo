@echo off
rem --------------------------------------------------------------------
rem Test script to validate some steps of the build procedures locally
rem Usage test.cmd <platform> <configuration>
rem        platform: either 'X64' or 'x86'
rem                  'amd64' is accepted as well and converted to 'X64'
rem                   (load-library) default is 'X64'
rem        configuration: either 'debug' or 'release'
rem                   (load-library) default is 'debug'
rem --------------------------------------------------------------------
@echo on

powershell -ExecutionPolicy Bypass %~dp0\..\load-podofo.ps1 
powershell -ExecutionPolicy Bypass %~dp0\..\EZTools\load-library.ps1 zlib %1 %2
powershell -ExecutionPolicy Bypass %~dp0\..\EZTools\load-library.ps1 libpng %1 %2
powershell -ExecutionPolicy Bypass %~dp0\..\EZTools\load-library.ps1 libjpeg %1 %2
powershell -ExecutionPolicy Bypass %~dp0\..\EZTools\load-library.ps1 freetype2 %1 %2
