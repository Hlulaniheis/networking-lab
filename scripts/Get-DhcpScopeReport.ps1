$Server = "vm-hyperv-host.lanislab.co.za"
$OutputCsv = "C:\Users\azureuser\Desktop\dhcp-scope-report.csv"

$Scopes = Get-DhcpServerv4Scope -ComputerName $Server

$Report = foreach ($Scope in $Scopes) {
    $Stats = Get-DhcpServerv4ScopeStatistics -ComputerName $Server -ScopeId $Scope.ScopeId
    [PSCustomObject]@{
        ScopeId      = $Scope.ScopeId
        Name         = $Scope.Name
        State        = $Scope.State
        StartRange   = $Scope.StartRange
        EndRange     = $Scope.EndRange
        FreeIPs      = $Stats.Free
        InUseIPs     = $Stats.InUse
        ReservedIPs  = $Stats.Reserved
        PercentInUse = $Stats.PercentageInUse
    }
}

$Report | Export-Csv -Path $OutputCsv -NoTypeInformation
$Report | Format-Table -AutoSize
Write-Host "`nReport exported to $OutputCsv" -ForegroundColor Green