# Networking Lab — Windows Server 2025

A hands-on networking lab built on Windows Server 2025, demonstrating DNS administration, DHCP configuration, Windows Firewall management, CLI troubleshooting, and PowerShell automation for network operations.

| | |
|---|---|
| **Domain** | `lanislab.co.za` |
| **DC / DNS / DHCP Server** | `vm-hyperv-host.lanislab.co.za` |
| **DC IP** | `192.168.100.1` |
| **DHCP Scopes** | `192.168.100.0/24` (LabScope), `192.168.200.0/24` (Guest-WiFi) |
| **Reverse Zone** | `100.168.192.in-addr.arpa` |

---

## Tech Stack

- **Windows Server 2025** — DNS and DHCP roles
- **PowerShell** — `DhcpServer` and `DnsServer` modules
- **CLI tools** — `netsh`, `ipconfig`, `ping`, `tracert`, `pathping`, `netstat`, `arp`
- **Windows Firewall** — `NetFirewallRule` cmdlets

---

## Tasks Completed

### DHCP

| Task | Method | Evidence |
|------|--------|----------|
| Reserve static IP by MAC address | `Add-DhcpServerv4Reservation` | [01](screenshots/01-dhcp-reservation.png), [02](screenshots/02-dhcp-reservation-gui.png) |
| Exclude an IP range from a scope | `Add-DhcpServerv4ExclusionRange` | [03](screenshots/03-dhcp-exclusion-range.png) |
| Create new scope with options | `Add-DhcpServerv4Scope` + `Set-DhcpServerv4OptionValue` | [04](screenshots/04-dhcp-new-scope-options.png) |
| Backup DHCP configuration | `netsh dhcp server export` | [05](screenshots/05-dhcp-backup-verify.png), [06](screenshots/06-dhcp-export.png) |
| Restore DHCP from backup | `netsh dhcp server import` | [07](screenshots/07-dhcp-restore-verify.png), [08](screenshots/08-dhcp-import-existing.png) |
| Authorize DHCP server in AD | `Add-DhcpServerInDC` | [09](screenshots/09-dhcp-authorize-in-ad.png) |

### DNS

| Task | Method | Evidence |
|------|--------|----------|
| Create A record | `Add-DnsServerResourceRecordA` | [10](screenshots/10-dns-a-record-ptr-error.png), [11](screenshots/11-dns-a-record-reverse-zone.png) |
| Create Reverse Lookup Zone + PTR | `Add-DnsServerPrimaryZone` + `Add-DnsServerResourceRecordPtr` | [11](screenshots/11-dns-a-record-reverse-zone.png) |
| Create CNAME alias | `Add-DnsServerResourceRecordCName` | [12](screenshots/12-dns-cname-fileshare.png) |
| Flush / display / register DNS cache | `ipconfig /flushdns`, `/displaydns`, `/registerdns` | [13](screenshots/13-ipconfig-dns-cache.png) |
| Create Forward Lookup Zone for a second domain | `Add-DnsServerPrimaryZone` (contoso.local) | [14](screenshots/14-dns-forward-zone-contoso.png) |
| Enable scavenging on a zone | `Set-DnsServerZoneAging` | [15](screenshots/15-dns-scavenging.png) |

### Windows Firewall

| Task | Method | Evidence |
|------|--------|----------|
| Inbound rule — allow port 1433 (SQL) | `New-NetFirewallRule` | [16](screenshots/16-firewall-inbound-sql-1433.png), [17](screenshots/17-firewall-verify-sql-1433.png) |
| Outbound rule — block port 25 (SMTP) | `New-NetFirewallRule` | [18](screenshots/18-firewall-outbound-block-smtp.png), [19](screenshots/19-firewall-verify-smtp-block.png) |
| Enable/disable firewall profiles | `Set-NetFirewallProfile` | [20](screenshots/20-firewall-profiles.png) |
| List all firewall rules | `Get-NetFirewallRule` | [21](screenshots/21-firewall-rule-list.png) |

### CLI Troubleshooting

| Task | Command | Evidence |
|------|---------|----------|
| Continuous ping | `ping -t` | [22](screenshots/22-ping-continuous.png) |
| Route trace + packet loss per hop | `tracert`, `pathping` | [23](screenshots/23-tracert-pathping.png) |
| Active TCP connections | `netstat -an` | [24](screenshots/24-netstat-an.png), [25](screenshots/25-netstat-udp.png) |
| ARP cache (IP → MAC) | `arp -a` | [26](screenshots/26-arp-a.png) |
| TCP port reachability | `Test-NetConnection -Port 3389` | [27](screenshots/27-test-netconnection-3389.png), [28](screenshots/28-test-netconnection-closed.png) |
| IP configuration and routing table | `Get-NetIPConfiguration`, `Get-NetRoute` | [29](screenshots/29-get-netipconfiguration.png), [30](screenshots/30-get-netroute.png) |

### PowerShell Scripts

| Script | Purpose | Evidence |
|--------|---------|----------|
| `Test-HostPorts.ps1` | Reads a CSV of hosts/ports, tests reachability with `Test-NetConnection`, exports results | [31–34](screenshots/33-script-port-scan-output.png) |
| `Get-DhcpScopeReport.ps1` | Audits all DHCP scopes and reports free/in-use/reserved IP counts | [35–36](screenshots/35-script-dhcp-scope-report.png) |
| `Resolve-DnsBatch.ps1` | Bulk DNS resolution with try/catch error handling, exports to CSV | [37, 39–41](screenshots/37-script-dns-batch-output.png) |

---

## What I Learned

- **Reverse DNS needs the Reverse Lookup Zone created first.** `Add-DnsServerResourceRecordA -CreatePtr` fails with WIN32 9715 if the `x.x.x.in-addr.arpa` zone doesn't already exist.
- **`netsh dhcp server import` refuses to overwrite existing scopes.** This is correct behavior — it protects against accidental corruption. Delete the target scope first if you're restoring.
- **The built-in Administrator account can be renamed** on a domain (here it became `azureuser`), but it retains SID ending in `-500` and full Domain Admin rights.
- **`Test-NetConnection` does both ping and TCP port test in one command.** Use it as the go-to reachability check.
- **`tracert` vs `pathping`** — tracert gives you the route fast; pathping computes per-hop packet loss but takes much longer. Use tracert for "where does it break," pathping for "which hop is dropping traffic."
- **Firewall rules are scoped by profile** (Domain / Private / Public). A rule created for `Any` profile applies everywhere — good for labs, risky in production.

---

## Lab Environment

- **Host:** Azure VM running Windows Server 2025
- **Domain Controller / DNS / DHCP:** `vm-hyperv-host.lanislab.co.za`
- **DC IP addresses:**
  - `192.168.100.1` (NAT-Switch, internal lab network)
  - `10.0.0.4` (Ext-Switch, Azure management network)
- **DHCP Scopes:**
  - `192.168.100.0/24` — LabScope, `.100–.200`, 8-hour leases
  - `192.168.200.0/24` — Guest-WiFi, `.100–.200`, 8-hour leases
- **DHCP Reservation:** `.50` reserved for MAC `00-11-22-33-44-55` (test printer)
- **DHCP Exclusion:** `.150–.160` excluded (reserved for servers)
- **DNS Zones:** `lanislab.co.za` (forward), `100.168.192.in-addr.arpa` (reverse), `contoso.local` (second forward)
- **DNS Records:** `fileserver.lanislab.co.za` → `192.168.100.10`, `fileshare` CNAME → `fileserver`

---

## Scripts

Custom PowerShell scripts are in the [`scripts/`](scripts/) folder — see [`scripts/README.md`](scripts/README.md) for details.

---

## Screenshots

All screenshots are in the [`screenshots/`](screenshots/) folder — see [`screenshots/README.md`](screenshots/README.md) for a full index.
