echo "Welcome to PowerShell Automation"
$FullName = Read-Host -Prompt 'Enter your Name '
$user = Read-Host -Prompt 'Enter the user name '

$passwd = Read-Host -Prompt "Enter the password for << $($user) >> "  -AsSecureString

 try {

 New-LocalUser $user -Password $passwd -FullName "$FullName" -Description "Sample Account by $($user)" -ErrorAction Stop
}
catch {
 Write-Host "Password Error, Password not set for the user $($user) "
 }

