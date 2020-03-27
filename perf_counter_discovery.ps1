if ($args.count -lt 1) {
    Write-Host "No or too few arguments found."
    exit
} 

$CounterName = "\$($args[0])\" -replace "_"," "
$DiscoveredCounters = typeperf -qx | Where-Object {$_.StartsWith($CounterName)}

$Label = $args[0].SubString(0, 2)
if(!$($DiscoveredCounters)){ 
    exit
}
$Counters = @()
$DiscoveredCounters | ForEach-Object {
    $Counters += @{ 
        "{#$($Label)NA}"=$_;
        "{#$($Label)LA}"=$($_ -split "\\")[-1];
    }
}

if ($Counters.Count -gt 1) {
    $Counters | ConvertTo-Json -Compress
}
elseif ($Counters.Count -eq 1) {
    "[$($Counters | ConvertTo-Json)]"
}