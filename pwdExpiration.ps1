$username=Read-Host -Prompt "Enter the username "

$user=Get-ADUser $username -Properties PasswordExpired, PasswordLastSet, PasswordNeverExpires

if($user.PasswordExpired){
Write-Host "The Password has expired"
}elseif($user.PasswordNeverExpires){
Write-Host "The Password will never expire"
}else{

$currentDate=Get-Date
$passwordLastSet=$user.PasswordLastSet
$passedTime=New-TimeSpan -Start $passwordLastSet -End $currentDate
$expirationTime=365-$passedTime.Days


Write-Host "$($passedTime.Days) $("days have passed since") $($passwordLastSet)"
Write-Host "Your password will expire in $expirationTime days"


}