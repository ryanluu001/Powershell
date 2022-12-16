#Get the current network adapter profile name
$interface = Get-NetConnectionProfile 
$interfaceAlias = $interface.InterfaceAlias

# Find and set current network profile to Domain
Set-Location -Path "HKLM:\SOFTWARE\Microsoft\Windows NT\CurrentVersion\NetworkList\Profiles"
$keys = Get-ChildItem
foreach($key in $keys)
{
$profilename = Get-ItemPropertyValue -Path $key.PSPath -Name Profilename
if($profilename = $interfaceAlias)
{
Write-Host "Changing key for network profile" $interfaceAlias
Set-ItemProperty -Path $key.PSPath -Name 'Category' -Value '2'
Stop-Service NlaSvc -Force -Verbose
Start-Service NlaSvc -Verbose
}
}