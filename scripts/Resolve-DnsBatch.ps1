param(
    [string]$HostnamesFile = "C:\Users\azureuser\Desktop\hostnames.txt",
    [string]$OutputCsv = "C:\Users\azureuser\Desktop\dns-resolution-report.csv"
)

$Hostnames = Get-Content $HostnamesFile

$Results = foreach ($Name in $Hostnames) {
    try {
        $Resolved = Resolve-DnsName -Name $Name -ErrorAction Stop
        [PSCustomObject]@{
            Hostname = $Name
            Status   = "OK"
            Result   = ($Resolved | Where-Object { $_.IPAddress } | Select-Object -First 1).IPAddress
        }
    }
    catch {
        [PSCustomObject]@{
            Hostname = $Name
            Status   = "FAILED"
            Result   = $_.Exception.Message
        }
    }
}

$Results | Export-Csv -Path $OutputCsv -NoTypeInformation
$Results | Format-Table -AutoSize
Write-Host "`nReport exported to $OutputCsv" -ForegroundColor Green