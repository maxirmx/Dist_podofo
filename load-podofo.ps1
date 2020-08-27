param (
  [string] $version="0.9.6"
)

$fname  = "podofo-$version" 
$fname1 = "$fname.tar"
$fname2 = "$fname1.gz"
$uri    =  "https://sourceforge.net/projects/podofo/files/podofo/$version/podofo-$version.tar.gz/download"

# https://adamtheautomator.com/automating-downloads-from-sourceforge/
Invoke-WebRequest -Uri $uri -OutFile $fname2 -UserAgent [Microsoft.PowerShell.Commands.PSUserAgent]::Chrome


& "C:\Program Files\7-Zip\7z" -aoa x $fname2 
& "C:\Program Files\7-Zip\7z" -aoa x $fname1 

Remove-Item $fname2
Remove-Item $fname1

Rename-Item -Path $fname -NewName podofo

# 
Copy-Item   -Path '.\patch\CMakeLists.txt' -Destination '.\podofo\test\TokenizerTest\CMakeLists.txt' -Force

