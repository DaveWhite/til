# Fix-IEUnsupportedVersion.ps1

This script configures a Windows policy registry value that disables Internet Explorer as a standalone browser experience on Windows virtual machines. It ensures the registry path exists and then sets `NotifyDisableIEOptions` to `0` as a `DWORD` under the Internet Explorer policy key.

Use this when a VM still shows legacy Internet Explorer behavior and you want to enforce the policy-backed setting consistently through automation.

Note that IE can still be used in Edge when viewing in Compatibility Mode.

## Script

```powershell
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
```