<#
List logged on users.
Source: http://stackoverflow.com/questions/17209456/get-list-of-logged-on-users-on-remote-windows-computer-from-a-list-computer
Date: 4/27/2017
Status: This doesn't work. It returns an error: 

    PS C:\windows\system32> C:\Users\cseelye\Desktop\Documents\Scripts\PS1Scripts\Logged On Users 2.ps1
    quser : No User exists for *
    At C:\Users\cseelye\Desktop\Documents\Scripts\PS1Scripts\Logged On Users 2.ps1:42 char:5
    +     quser /server:$Computer | Select-Object -Skip 1 | ForEach-Object  ...
    +     ~~~~~~~~~~~~~~~~~~~~~~~
        + CategoryInfo          : NotSpecified: (No User exists for *:String) [], RemoteException
        + FullyQualifiedErrorId : NativeCommandError

ToDo:
    * get it working
    * modify to run on an inline computer name or list of computers, to avoid an external list


#>


<#
.Synopsis
Queries a computer to check for interactive sessions

.DESCRIPTION
This script takes the output from the quser program and parses this to PowerShell objects

.NOTES   
Name: Get-LoggedOnUser
Author: Jaap Brasser
Version: 1.1
DateUpdated: 2013-06-26

.LINK
http://www.jaapbrasser.com

.PARAMETER ComputerName
The string or array of string for which a query will be executed

.EXAMPLE
.\Get-LoggedOnUser.ps1 -ComputerName server01,server02

Description:
Will display the session information on server01 and server02

.EXAMPLE
'server01','server02' | .\Get-LoggedOnUser.ps1

Description:
Will display the session information on server01 and server02
#>
param(
[CmdletBinding()] 
[Parameter(ValueFromPipeline=$true,
           ValueFromPipelineByPropertyName=$true)]
[array[]]$ComputerName = (gc C:\_MyTemp\computers.txt)
)

process {
foreach ($Computer in $ComputerName) {
    quser /server:$Computer | Select-Object -Skip 1 | ForEach-Object {
        $CurrentLine = $_.Trim() -Replace '\s+',' ' -Split '\s'
        $HashProps = @{
            UserName = $CurrentLine[0]
            ComputerName = $Computer
        }

        # If session is disconnected different fields will be selected
        if ($CurrentLine[2] -eq 'Disc') {
                $HashProps.SessionName = $null
                $HashProps.Id = $CurrentLine[1]
                $HashProps.State = $CurrentLine[2]
                $HashProps.IdleTime = $CurrentLine[3]
                $HashProps.LogonTime = $CurrentLine[4..6] -join ' '
        } else {
                $HashProps.SessionName = $CurrentLine[1]
                $HashProps.Id = $CurrentLine[2]
                $HashProps.State = $CurrentLine[3]
                $HashProps.IdleTime = $CurrentLine[4]
                $HashProps.LogonTime = $CurrentLine[5..7] -join ' '
        }

        New-Object -TypeName PSCustomObject -Property $HashProps |
        Select-Object -Property UserName,ComputerName,SessionName,Id,State,IdleTime,LogonTime
    } | Out-GridView -Title "Users Logged in $Computer"

   }
}