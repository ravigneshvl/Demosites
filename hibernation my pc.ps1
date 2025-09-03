# Define the target hibernation time (e.g., 10:00 PM)
$hibernateTime = "22:00"

# Get the current time
$currentTime = Get-Date

# Calculate the time difference until hibernation
$timeDifference = New-TimeSpan -Start $currentTime -End (Get-Date -Hour ($hibernateTime.Substring(0,2)) -Minute ($hibernateTime.Substring(3,2)) -Second 0)

# If the target time is in the past (e.g., script run after 10 PM for same day), adjust to next day
if ($timeDifference.TotalSeconds -lt 0) {
    $timeDifference = New-TimeSpan -Start $currentTime -End ((Get-Date).AddDays(1) -Hour ($hibernateTime.Substring(0,2)) -Minute ($hibernateTime.Substring(3,2)) -Second 0)
}

# Convert time difference to seconds
$sleepSeconds = [int]$timeDifference.TotalSeconds

# Wait until the specified time
Write-Host "Waiting for $sleepSeconds seconds until hibernation..."
Start-Sleep -Seconds $sleepSeconds

# Hibernate the computer
Write-Host "Hibernating now..."
Stop-Computer -Hibernate -Force
