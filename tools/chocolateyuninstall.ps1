$sysmonInstalled = Test-Path -Path "C:\ProgramData\chocolatey\lib\sysmon\tools\Sysmon64.exe"

Write-Host "Trying to uninstall sysmon"
Write-Host "sysmonInstalled: ${sysmonInstalled}"

if ($sysmonInstalled) {
  & "C:\ProgramData\chocolatey\lib\sysmon\tools\Sysmon64.exe" -u
}