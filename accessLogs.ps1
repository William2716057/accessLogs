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
