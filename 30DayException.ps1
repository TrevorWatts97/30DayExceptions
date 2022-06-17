#Paste this install-module into another powershell terminal if you need to
#Install-Module -Name ImportExcel

Import-Module ActiveDirectory
Import-Module ImportExcel

$group = "30dayExceptionTest"

#Clear current members
Get-ADGroupMember $group | ForEach-Object {Remove-ADGroupMember -Identity $group $_ -Confirm:$false}

#Import file
$filename = "C:\Scripts\30DayExceptions.xlsx"
$Users = Import-Excel $filename

#Add each user into AD Group
foreach($User in $Users)
{ 
    $Sam = $User.UserPrincipalName -replace ".{10}$"
    Add-ADGroupMember -Identity $group -Members $Sam
}