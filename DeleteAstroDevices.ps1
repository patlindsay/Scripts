$astroDevices = Get-PnpDevice | Where-Object {($_.Name -match "^Astro*")}

Write-Host $astroDevices

Disable-PnpDevice $astroDevices.DeviceId -Confirm -WhatIf

for each

$result = Get-PnpDevice | Where-Object {($_.PNPDeviceID == $astroDevices

if ($result )

Write-Host $result