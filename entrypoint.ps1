$VerbosePreference = "ignore"
$sleep = 5
while ($true)
{
    $datediff = (New-TimeSpan -Seconds 5).TotalMilliseconds
    $filter = "*/System/TimeCreated[timediff(@SystemTime) <= $datediff] and *[EventData/Data[@Name='sc-status'] >'400']"
    Get-WinEvent -MaxEvents 10 -FilterXPath $filter -ProviderName "Microsoft-Windows-IIS-Logging" -ErrorAction SilentlyContinue | 
        Select-Object @{Name = "time"; e = {$_.Properties[2].value}}, @{Name = "VERB"; e = {$_.Properties[8].value}}, @{Name = "ClientIP"; e = {$_.Properties[3].value}},
    @{Name = "URI"; e = {$_.Properties[9].value}}, @{Name = "Query"; e = {$_.Properties[10].value}}, @{Name = "Status"; e = {$_.Properties[11].value}}, 
    @{Name = "host"; e = {$_.Properties[21].value}} | Format-Table
    Start-Sleep $sleep
}
