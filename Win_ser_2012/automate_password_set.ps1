$ClientIP = 18.222.37.97
$username = "kevin"
$passwd = 'asdf7@Ab'


#$test_command = "Invoke-Command -ComputerName 18.221.171.39 -ScriptBlock { net user $($username) $($passwd) } -Credential Administrator"

echo `n
echo $username
$test_command = "Invoke-Command -ComputerName 18.222.37.97 -ScriptBlock { net user $($username) $($passwd) } -Credential Administrator"
#this below command is working fine than previous(above)
echo $test_command

#Invoke-Command -ComputerName 18.221.171.39 -ScriptBlock { net user kevin asdf2@Ab } -Credential Administrator


Invoke-Expression $test_command