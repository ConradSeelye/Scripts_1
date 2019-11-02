
<#
2/17/2017: This works.
Note: the multiple recipients have to be in a text array.


#>

Clear-Host 

$User = "hoshiyama.ygs@outlook.com"
$PWord = ConvertTo-SecureString -String "hjeH2hdw@d" -AsPlainText -Force
$Credential = New-Object -TypeName "System.Management.Automation.PSCredential" -ArgumentList $User, $PWord

$Recipients = @("8055919118@vtext.com", "cseelye@seattleymca.org")
Write-Host $Recipients

Send-MailMessage -From "hoshiyama.ygs@outlook.com" `
	-To $Recipients `
	-Subject "test i" `
	-Body "test" `
	-Priority High `
	-SmtpServer smtp.live.com `
	-Port 587 `
	-useSSL `
	-Credential $Credential 

