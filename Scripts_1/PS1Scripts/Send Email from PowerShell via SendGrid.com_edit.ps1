# status: this works
# date: 9/29/2017
# environment: on YGS VM YGSProdDW and my laptop AO003371LT
# UserName = "hoshiyama.ygs"
# Password is the 12 character password used when creating the sendgrid account;  not the long guid-like password.

Clear-Host

$To = @("Conrad <conrads1966@gmail.com>")
# $To = @("Conrad <cseelye@seattleymca.org>")
# Format for multiple recipients:
# $To = @("Conrad <cseelye@seattleymca.org>", "Tara <tchamberlain@seattleymca.org>")

$Subject = "from SendGrid 13:39"
$Body = "my email body"
$From = "conrads1966@gmail.com"
$UserName = "cbs66"
$passwordFile = "C:\_temp\passwordSendGrid.txt"

# First time create password file
if (! (Test-Path $passwordFile))
{
    Read-Host -AsSecureString | convertfrom-securestring | out-file $passwordFile
}
$pass = cat C:\_temp\passwordSendGrid.txt | ConvertTo-SecureString
$MyCred = New-Object -TypeName System.Management.Automation.PSCredential -ArgumentList $UserName, $pass

Write-Host "Sending email."
# Send email

send-mailmessage -from $From `
    -to $To `
    -subject $Subject `
    -body $Body `
    -smtpServer smtp.sendgrid.net `
    -useSSL `
    -Port 587 `
    -Credential $MyCred

