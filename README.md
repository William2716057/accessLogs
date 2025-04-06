# 🛡️ Windows Logon Event Viewer Script

This PowerShell script retrieves and displays all successful logon events (Event ID 4624) from the Windows Security event log within the past 24 hours.

## 📜 Script Overview

```powershell
# Set current date and time
$CurrentTime = Get-Date

# Subtract 24 hours to define the start time
$StartTime = $CurrentTime.AddHours(-24)

# Event ID for successful logins
$eventID = 4624

# Get logon events from Security log within the past 24 hours
$logonEvents = Get-WinEvent -FilterHashtable @{
    LogName   = 'Security'
    ID        = $eventID
    StartTime = $StartTime
} -ErrorAction SilentlyContinue

# Display relevant information
foreach ($event in $logonEvents) {
    $properties   = $event.Properties
    $timeCreated  = $event.TimeCreated
    $accountName  = $properties[5].Value
    $accountDomain = $properties[6].Value
    $logonType    = $properties[8].Value
    $workstation  = $properties[11].Value
    $sourceIP     = $properties[18].Value

    Write-Host "Time:        $timeCreated"
    Write-Host "User:        $accountDomain\$accountName"
    Write-Host "Logon Type:  $logonType"
    Write-Host "Workstation: $workstation"
    Write-Host "Source IP:   $sourceIP"
    Write-Host "----------------------------------------"
}
```
## 🔍 Field Explanations
### 👤 User
This shows the domain and account name of the user that logged in:
```
User: DOMAIN\Username
```
- AccountDomain: The domain (or local machine name) the user belongs to.
- AccountName: The username used during the login.

🔢 Logon Type
The logon type describes how the user logged into the system. Common values include:

2	Interactive (e.g., directly at keyboard/console)
3	Network (e.g., accessing shared folders or remote desktop)
4	Batch (e.g., scheduled tasks)
5	Service (used by services like Windows Update)
7	Unlock (a user unlocked their workstation)
8	NetworkCleartext (network logon with plaintext credentials)
10	RemoteInteractive (e.g., RDP logon)
11	CachedInteractive (logon using cached credentials, such as when domain controller is unreachable)
