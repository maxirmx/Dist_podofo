param (
#  platform: either 'X64' or 'x86'
#            'amd64' is accepted as well and converted to 'X64'
   [parameter(Mandatory=$false)][string]$platform="X64",
#  platform: either 'debug' or 'release'
   [parameter(Mandatory=$false)][string]$configuration="debug"
)

function load {
  param (
    [string] $libname,
    [string] $platform = "X64",
    [string] $configuration = "debug"
  )

  $fname = "$libname.7z"
  $dname = $libname
  $uri = "http://www.samsonov.net/wp/assets/Dist_$libname/$platform-$configuration/$fname"
  
  Write-Host "`nLoading $uri into $dname/$fname `n"

  New-Item -ItemType Directory -Force -Path $dname

  cd $dname

  Invoke-WebRequest -Uri $uri -OutFile $fname
  & "C:\Program Files\7-Zip\7z" -aoa x $fname
  Remove-Item $fname

  cd ..
}

 switch($platform) {
   "X64"   { break; } 
   "x86"   { break; } 
   "amd64" { $platform = "X64"; break; } 
   default { "load-libraries.ps1: platform <$platform> was not recognized"; exit (-1);  } 
 }

 switch($configuration) {
   "release"   { break; } 
   "debug"     { break; } 
   default     { "load-libraries.ps1: configuration <$configuration> was not recognized"; exit (-1);  } 
 }


load "zlib"  $platform $configuration
load "libpng" $platform $configuration

