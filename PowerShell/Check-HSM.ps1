# Checks the HSM for functionality. It will return OK and OK if everything is OK. 
$outputPath="C:\temp"
$file = "C:\Program Files (x86)\nCipher\nfast\bin\enquiry.exe"
if(-not(Test-Path $file))
{
    Write-Host "The Thales HSM tools are not installed in the expected place on this PC."
    exit
}
$command = '& "C:\Program Files (x86)\nCipher\nfast\bin\enquiry.exe"'
$output = Invoke-Expression -Command $command

$connectivityMatch = Select-String -Pattern "connection status\s+(.+)" -InputObject $output
$connectivityStatus = $connectivityMatch.Matches.Groups[1].Value
$connectivityStatus = $connectivityStatus.Substring(0,2)
if($connectivityStatus -ne "OK" )
{
    $connectivityStatus = "returning an error or connectivity is down."
}

$hardwareMatch = Select-String -Pattern "hardware status\s+(.+)" -InputObject $output
$hardwareStatus = $hardwareMatch.Matches.Groups[1].Value
if($hardwareStatus -ne "OK" )
{
    $hardwareStatus = "returning an error or no value (could indicate that connectivity is down)."
}

Write-Host "Connectivity to the HSM is $connectivityStatus"
write-host "The HSM hardware status is $hardwareStatus"

$currentDate = Get-Date -Format "MM/dd/yyyy HH:mm"
$statusText = $currentDate + " " + $hardwareStatus
if($hardwareStatus -eq "OK")
{
    $statusText | Add-Content -Path "$outputPath\HSMStatus.txt"
}
