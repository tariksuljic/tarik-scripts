#Get the username
$username=Read-Host -Prompt "Enter the username "

#Get the user
$user= Get-ADUser $username -Properties PasswordExpired

#Check if the password has expired
if($user.PasswordExpired -eq $false){
    Write-Host "Users password has not expired yet"
    exit
}

#Remove the users manager
$user | Set-ADUser -clear Manager

#Get the users groups
$userGroups=Get-ADPrincipalGroupMembership $username | Select-Object Name

#Remove the user from each group
foreach($group in $userGroups){
    
    try{
    
    Remove-ADGroupMember -Identity $group.Name -Members $username 
    }
    catch{
     Write-Host "The group 'Domain Users' cannot be removed because its the users primary group"
    }
}

#Disable users account
Disable-ADAccount -Identity $username

#Move to the "Obsolete Accounts" Organizational Unit
$user | Move-ADObject -TargetPath "OU=Obsolete Accounts,DC=tariklab,DC=local"