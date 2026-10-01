param(
    [string]$HostsFile = "C:\Users\azureuser\Desktop\hosts.txt",
    [string]$OutputCsv = "C:\Users\azureuser\Desktop\port-scan-results.csv"
)

$Targets = Import-Csv $HostsFile

$Results = foreach ($Target in $Targets) {
    $Ports = $Target.Ports -split ","
    foreach ($Port in $Ports) {
        $Test = Test-NetConnection -ComputerName $Target.Host -Port $Port -WarningAction SilentlyContinue
        [PSCustomObject]@{
            Host      = $Target.Host
            Port      = $Port
            Open      = $Test.TcpTestSucceeded
            Timestamp = (Get-Date).ToString("yyyy-MM-dd HH:mm:ss")
        }
    }
}

$Results | Export-Csv -Path $OutputCsv -NoTypeInformation
$Results | Format-Table -AutoSize
Write-Host "`nResults exported to $OutputCsv" -ForegroundColor Green