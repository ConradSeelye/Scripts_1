<#
Check if the MSSQLSERVER service is stopped. If so, start it and send an alert email.
Date as of: 9/29/2017

#>

# Clear-Host
$MyServiceName = "MSSQLSERVER"

$MyService = Get-Service | Where-Object {$_.name -like "MSSQLSERVER"} # | Format-Table status
$MyStatus = $MyService.Status
$MyServer = "Galaxian"

# If ($MyStatus -eq "Stopped")  {$MyService.Start()}
# If ($MyStatus -eq "Paused") {$MyService.Continue()}


If ($MyStatus -eq "Stopped" -OR $MyStatus -eq "Paused") {
    # Write-Host "sql is stopped or paused"

    # Write-Host "Starting service"
    If ($MyStatus -eq "Stopped") {$MyService.Start()}
    If ($MyStatus -eq "Paused") {$MyService.Continue()}

    # Write-Host "Sending email."
    $To = @("Conrad <cseelye@seattleymca.org>")
    # Format for multiple recipients:
    # $To = @("Conrad <cseelye@seattleymca.org>", "Tara <tchamberlain@seattleymca.org>")

    $Subject = "YGS Alert: " + $MyServer + " MSSQLSERVER service. Test 10/2/2017 15:43 via task"
    $Body = "MSSQLSERVER service was found stopped on " + $MyServer + ". It was restarted."
    $From = "cseelye@seattleymca.org"
    $UserName = "hoshiyama.ygs"
    $passwordFile = "C:\_temp\passwordSendGrid.txt"

    # First time create password file
    if (! (Test-Path $passwordFile))
    {
        Read-Host -AsSecureString | convertfrom-securestring | out-file $passwordFile
    }
    $pass = cat C:\_temp\passwordSendGrid.txt | ConvertTo-SecureString
    $MyCred = New-Object -TypeName System.Management.Automation.PSCredential -ArgumentList $UserName, $pass

    send-mailmessage -from $From `
        -to $To `
        -subject $Subject `
        -body $Body `
        -smtpServer smtp.sendgrid.net `
        -useSSL `
        -Port 587 `
        -Credential $MyCred `
        -Priority High
    }


RETURN
EXIT
