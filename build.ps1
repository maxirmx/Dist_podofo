Param (
#  platform: either 'amd64' or 'x86'
#            'X64' is accepted as well and converted to 'amd64'
   [parameter(Mandatory=$false)][string]$platform="amd64",
#  platform: either 'debug' or 'release'
   [parameter(Mandatory=$false)][string]$configuration="debug",
# configure switch implies running vcvarsall.bat through CmdScript to inherit environment variables (local build)
   [parameter()][switch]$configure
)

 switch($platform) {
   "X64"   { $platform = "amd64"; break;  } 
   "x86"   { break; } 
   "amd64" { break; } 
   default { "build.ps1: platform <" + $platform + "> was not recognized"; exit (-1);  } 
 }

 switch($configuration) {
   "release" { break; } 
   "debug"   { break; } 
   default   { "build.ps1: configuration <" + $configuration + "> was not recognized"; exit (-1);  } 
 }

$dname = "build"

 if ($configure) {
  .\EZTools\cmd-script.ps1 "C:\Program Files (x86)\Microsoft Visual Studio 14.0\VC\vcvarsall.bat" $platform
  $cmake = "C:\Program Files\CMake\bin\cmake" 
 } else {
  $cmake = "cmake"
 }



#cmake -G "NMake Makefiles" podofo -DCMAKE_INCLUDE_PATH="%FTDIR%\include;%PNGDIR%\include;%JPEGDIR%\include;%ZLIBDIR%\include" -DCMAKE_LIBRARY_PATH="%FTDIR%\lib;%PNGDIR%\lib;%JPEGDIR%\lib;%ZLIBDIR%\lib" -DPODOFO_BUILD_SHARED:BOOL=FALSE -DFREETYPE_LIBRARY_NAMES_DEBUG=freetype239MT_D -DFREETYPE_LIBRARY_NAMES_RELEASE=freetype239MT
#cmake --build . 

cd podofo
New-Item -ItemType Directory -Force -Path $dname
cd $dname

set FTDIR="..\..\freetype"
set PNGDIR="..\..\libpng"
set JPEGDIR="..\..\libjpeg"
set ZLIBDIR="..\..\zlib" 


dir ../../freetype/lib

$bp1 =  @("-G","""NMake Makefiles""",
		"-D","CMAKE_INCLUDE_PATH=""../../freetype/include;../../libpng/include;../../libjpeg/include;../../zlib/include""",
                "-D","CMAKE_LIBRARY_PATH=""../../freetype;../../libpng\lib;../../libjpeg/lib;../../zlib/lib""", 
                "-D","PODOFO_BUILD_SHARED:BOOL=FALSE", 
		"-D","ZLIB_LIBRARY=../../zlib/lib",
                "-D","PNG_LIBRARY=../../libpng/lib",
                "-D","JPEG_LIBRARY=../../libjpeg/lib",
                "-D","FREETYPE_LIBRARY=../../freetype/lib",
                "-D","ZLIB_INCLUDE_DIR=../../zlib/include" 
                "..")


# Manually packaged in .appveyor.yml script
# $bp2 =  @("--build",  ".",
#           "--target", "package")

$bp2 =  @("--build",  ".")


& $cmake  $bp1
& $cmake  $bp2

cd ../..