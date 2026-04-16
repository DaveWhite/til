# Disables IE as a stand-alone browser on Windows VMs
# This command would be executed:  reg add "HKEY_LOCAL_MACHINE\SOFTWARE\Policies\Microsoft\Internet Explorer\Main" /v NotifyDisableIEOptions /t REG_DWORD /d 0 /f
$registryPath = "HKLM:\SOFTWARE\Policies\Microsoft\Internet Explorer\Main"
$Name = "NotifyDisableIEOptions"
$value = "0"

IF(!(Test-Path $registryPath))
  {
    New-Item -Path $registryPath -Force | Out-Null
    New-ItemProperty -Path $registryPath -Name $name -Value $value `
    -PropertyType DWORD -Force | Out-Null}
 ELSE {
    New-ItemProperty -Path $registryPath -Name $name -Value $value `
    -PropertyType DWORD -Force | Out-Null}
