# Define the target hibernation time (e.g., 10:00 PM)
$hibernateTime = "22:00"

# Get the current time
$currentTime = Get-Date

# Parse the hibernation time into hours and minutes
$hibernateHour = [int]$hibernateTime.Substring(0,2)
$hibernateMinute = [int]$hibernateTime.Substring(3,2)

# Create today's hibernation DateTime
$targetTimeToday = Get-Date -Hour $hibernateHour -Minute $hibernateMinute -Second 0

# If the target time is already passed today, set for the next day
if ($currentTime -gt $targetTimeToday) {
    $targetTimeToday = $targetTimeToday.AddDays(1)
}

# Calculate the time difference
$timeDifference = $targetTimeToday - $currentTime
$sleepSeconds = [int]$timeDifference.TotalSeconds

# Output and wait
Write-Host "Waiting for $sleepSeconds seconds until hibernation at $($targetTimeToday)..."
Start-Sleep -Seconds $sleepSeconds

# Hibernate the computer
Write-Host "Hibernating now..."
Stop-Computer -Hibernate -Force
