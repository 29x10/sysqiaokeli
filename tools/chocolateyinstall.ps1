$ErrorActionPreference = 'Continue' # stop on all errors
$toolsDir   = "$(Split-Path -parent $MyInvocation.MyCommand.Definition)"

$fileLocation = Join-Path -Path $toolsDir -ChildPath "Sysmon.zip"

$configLocation = Join-Path -Path $toolsDir -ChildPath "sysmonconfig-export.xml"

$packageArgs = @{
  packageName   = $env:ChocolateyPackageName
  unzipLocation = $toolsDir
  file          = $fileLocation
}

Install-ChocolateyZipPackage @packageArgs

$sysmonVersion = (Get-ChildItem "C:\ProgramData\chocolatey\lib\sysmon\tools\Sysmon64.exe").VersionInfo.ProductVersion

$sysmonInstalled = Test-Path -Path "C:\Windows\Sysmon64.exe"

if ($sysmonInstalled) {
  if ($sysmonVersion -eq "14.16") {
    Write-Host "Sysmon v14.16 already installed, updating config"
    & "C:\ProgramData\chocolatey\lib\sysmon\tools\Sysmon64.exe" -c "$configLocation"
  } else {
    Write-Host "Upgrading sysmon, uninstall previous version"
    & "C:\ProgramData\chocolatey\lib\sysmon\tools\Sysmon64.exe" -u
  }
} else {
  & "C:\ProgramData\chocolatey\lib\sysmon\tools\Sysmon64.exe" -accepteula -i "$configLocation"
}