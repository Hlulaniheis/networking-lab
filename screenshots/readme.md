# Screenshots Index

Visual evidence of each networking task, numbered in the order completed.

| # | File | Task |
|---|------|------|
| 01 | `01-dhcp-reservation.png` | DHCP reservation created by MAC address (PowerShell) |
| 02 | `02-dhcp-reservation-gui.png` | DHCP reservation visible in DHCP Manager GUI |
| 03 | `03-dhcp-exclusion-range.png` | IP exclusion range added to scope |
| 04 | `04-dhcp-new-scope-options.png` | New Guest-WiFi scope + options configured |
| 05 | `05-dhcp-backup-verify.png` | DHCP backup file verified with Get-Item |
| 06 | `06-dhcp-export.png` | `netsh dhcp server export` command |
| 07 | `07-dhcp-restore-verify.png` | Verify scopes after restore attempt |
| 08 | `08-dhcp-import-existing.png` | Import refuses to overwrite existing scope |
| 09 | `09-dhcp-authorize-in-ad.png` | DHCP server authorized in Active Directory |
| 10 | `10-dns-a-record-ptr-error.png` | A record created — PTR failed (reverse zone missing) |
| 11 | `11-dns-a-record-reverse-zone.png` | Reverse zone + PTR record successfully created |
| 12 | `12-dns-cname-fileshare.png` | CNAME fileshare → fileserver resolution chain |
| 13 | `13-ipconfig-dns-cache.png` | Flush, display, register DNS cache |
| 14 | `14-dns-forward-zone-contoso.png` | Second forward lookup zone (contoso.local) |
| 15 | `15-dns-scavenging.png` | DNS scavenging enabled on lanislab.co.za |
| 16 | `16-firewall-inbound-sql-1433.png` | Inbound rule — allow TCP 1433 (SQL) |
| 17 | `17-firewall-verify-sql-1433.png` | Verify inbound rule with Get-NetFirewallRule |
| 18 | `18-firewall-outbound-block-smtp.png` | Outbound rule — block TCP 25 (SMTP) |
| 19 | `19-firewall-verify-smtp-block.png` | Verify outbound rule |
| 20 | `20-firewall-profiles.png` | Enable/disable firewall profiles |
| 21 | `21-firewall-rule-list.png` | List enabled firewall rules |
| 22 | `22-ping-continuous.png` | `ping -t` continuous test |
| 23 | `23-tracert-pathping.png` | `tracert` and `pathping` route analysis |
| 24 | `24-netstat-an.png` | `netstat -an` TCP listening ports |
| 25 | `25-netstat-udp.png` | `netstat -an` UDP listeners |
| 26 | `26-arp-a.png` | `arp -a` cache (IP → MAC) |
| 27 | `27-test-netconnection-3389.png` | Test-NetConnection — port 3389 open |
| 28 | `28-test-netconnection-closed.png` | Test-NetConnection — closed port failure |
| 29 | `29-get-netipconfiguration.png` | Get-NetIPConfiguration output |
| 30 | `30-get-netroute.png` | Get-NetRoute routing table |
| 31 | `31-script-test-hostports.png` | Test-HostPorts.ps1 script content |
| 32 | `32-script-hosts-file.png` | hosts.txt input file |
| 33 | `33-script-port-scan-output.png` | Test-HostPorts.ps1 execution output |
| 34 | `34-script-port-scan-csv.png` | port-scan-results.csv |
| 35 | `35-script-dhcp-scope-report.png` | Get-DhcpScopeReport.ps1 execution output |
| 36 | `36-script-dhcp-report-csv.png` | dhcp-scope-report.csv |
| 37 | `37-script-dns-batch-output.png` | Resolve-DnsBatch.ps1 execution output |
| 38 | `38-script-dns-report-csv.png` | dns-resolution-report.csv |
| 39 | `39-script-resolve-dns.png` | Resolve-DnsBatch.ps1 script content |
| 40 | `40-script-hostnames-file.png` | hostnames.txt input file |
| 41 | `41-script-dns-report-csv.png` | dns-resolution-report.csv contents |

## Notes

- All commands run on the domain controller `vm-hyperv-host.lanislab.co.za` (Windows Server 2025).
- Domain: `lanislab.co.za` — DC IP `192.168.100.1`.
- The lab was completed without a separate client machine; tasks were verified against the DC's own network stack.
- Tasks requiring a second client VM (rogue DHCP hunt, DHCP lease verification from a client) are documented as not tested in this lab.
