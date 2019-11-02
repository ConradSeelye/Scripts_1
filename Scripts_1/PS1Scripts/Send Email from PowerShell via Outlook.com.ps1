<#
This is the basic template for sending email from PowerShell.
As of 5/25/2017
Source for part of this:  https://stackoverflow.com/questions/29780760/powershell-script-get-account-information-from-an-outside-file

ToDo:
* Test for folder path and create if it doesn't exist
* Note and document account freezing conditions.
* Document module requirements. 

Notes:
* This is the maximum subject length that can appear in email: 255 characters.  If there are 256+ characters, then the there is <...> starting at character 253.
$Subject = "test31b12345000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000abcdef"

* 22 characters is the maximum email body length that will be received at all to text.republicwireless.com. Other carriers might have different @body length limits. 
If that limit is exceeded, then the message will not be received at all. It does not send with a truncated subject. 
$Body = "abcdefghijklmnopqrstuv"

* It stores the account password in a (slightly) secure .txt file.  If the file does not exist, then it will prompt you for the password and then create the file. Subsequently, it will reference that file as long it exists. 

* There might be limits on how many times this can be run/tested, after which the account will freeze. 


#>


Clear-Host

# $To = @("Conrad <cseelye@seattleymca.org>")
# Format for multiple recipients:
$To = @("Conrad <cseelye@seattleymca.org>", "shill@seattleymca.org")

$Subject = "my subject"
$Body = "my email body"
$From = "hoshiyama2.ygs@outlook.com"
$UserName = "hoshiyama.ygs@outlook.com"
$passwordFile = "C:\_temp\password.txt"

# First time create password file
if (! (Test-Path $passwordFile))
{
    Read-Host -AsSecureString | convertfrom-securestring | out-file $passwordFile
}
$pass = cat C:\_temp\password.txt | ConvertTo-SecureString

$MyCred = New-Object -TypeName System.Management.Automation.PSCredential -ArgumentList $UserName, $pass

Write-Host "Sending email."
# Send email
send-mailmessage -from $From `
    -to $To `
    -subject $Subject `
    -body $Body `
    -smtpServer smtp.live.com `
    -useSSL `
    -Port 587 `
    -Credential $MyCred





