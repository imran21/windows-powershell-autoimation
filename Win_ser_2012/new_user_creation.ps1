Write-Host "New Local User Creation"
echo `n 

$username = Read-Host -Prompt 'Enter New Username'
$password = Read-Host -Prompt 'Enter New password' -AsSecureString

NET USER $username  $password /ADD
