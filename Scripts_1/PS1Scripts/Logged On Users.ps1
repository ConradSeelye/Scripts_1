<#
List the logged on users of a computer.
Date: 4/27/2017
Source: http://stackoverflow.com/questions/17209456/get-list-of-logged-on-users-on-remote-windows-computer-from-a-list-computer
ToDo:
    * modify this to run on an inline list of computers to avoid having to use an external text file. 
    * identify only the users that are connected by RDP

#>

function Get-MyLoggedOnUsers
{
  param([Array]$Computer)
  Get-WmiObject Win32_LoggedOnUser -ComputerName $Computer |
  Select __SERVER, Antecedent -Unique |
  %{"{0} : {1}\{2}" -f $_.__SERVER, $_.Antecedent.ToString().Split('"')[1],       $_.Antecedent.ToString().Split('"')[3]}
}

$Computers = gc C:\_MyTemp\Computers.txt

Get-MyLoggedOnUsers $Computers