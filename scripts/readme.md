# Scripts

Custom PowerShell scripts written for this networking lab. Each script is standalone and can be run on any Windows Server or Windows 10/11 machine with the appropriate modules installed.

---

## Test-HostPorts.ps1

Reads a CSV of hosts and ports, tests reachability with `Test-NetConnection`, and exports the results to a timestamped CSV.

**What it does:**
- Imports a CSV with columns: `Host`, `Ports` (comma-separated)
- Loops through each host and each port
- Uses `Test-NetConnection` to check if the TCP port is reachable
- Records host, port, open/closed status, and timestamp
- Exports results to CSV and displays a summary table

**Input file (hosts.txt):**
