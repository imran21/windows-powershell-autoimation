echo "IIS ApplicationPool creation and Site configuration"


Set-WebConfigurationProperty -Filter "/system.webServer/security/authentication/windowsAuthentication" -Name Enabled -Value False
Set-WebConfigurationProperty -Filter "/system.webServer/security/authentication/anonymousAuthentication" -Name Enabled -Value False
Set-WebConfigurationProperty -Filter "/system.webServer/security/authentication/basicAuthentication" -Name Enabled -Value True
Set-WebConfigurationProperty -Filter "/system.webServer/security/authentication/digestAuthentication" -Name Enabled -Value False


$App_Pool_Name = Read-Host -Prompt 'Enter new ApppoolName'
#Create an AppPool
New-WebAppPool $($App_Pool_Name)
Write-Host "-----------------------------------------"
Write-Host "Here are the list of users in this System"
Write-Host "-----------------------------------------"

$user_name_list = Get-WmiObject -Class Win32_UserAccount
$user_name_list_len = $user_name_list.length
for($i=0; $i -lt $user_name_list_len; $i++)
{
Write-Host $user_name_list[$i].Name
}

Write-Host "-----------------------------------------"
Write-Host "Choose a user to asscociate with AppPool"

$App_Pool_user_identity_uname = Read-Host -Prompt 'Enter AppPool Identity Username'
$App_Pool_user_identity_passwd = Read-Host -Prompt 'Enter AppPool Identity Password'

Set-ItemProperty IIS:\AppPools\$($App_Pool_Name) -name processModel -value @{userName= $($App_Pool_user_identity_uname); password=$($App_Pool_user_identity_passwd ); identitytype=3}
Write-Host "------------------------------------------------"
Write-Host "Here are the list of AppPools in this IIS System"
Write-Host "------------------------------------------------"

$appPool_list = Get-ChildItem IIS:\apppools
$appPool_list_len = $appPool_list.length
for($j=0; $j -lt $appPool_list_len; $J++)
{
Write-Host $appPool_list[$j].Name
}


Write-Host "------------------------------------------------"

$IIS_Site_Name = Read-Host -Prompt 'Enter IIS Site Name'
$ISS_Application_path = Read-Host -Prompt 'Enter Path of Web Application'
New-Item iis:\Sites\$($IIS_Site_Name) -bindings @{protocol="http";bindingInformation=":80:"} -physicalPath $($ISS_Application_path)

$IIS_Application_name = Read-Host -Prompt 'Enter Web Application Name'


Write-Host $IIS_Site_Name 
$IIS_webApp_path = "IIS:\Sites\$($IIS_Site_Name)\$($IIS_Application_name)"
echo $IIS_webApp_path


New-Item $IIS_webApp_path -physicalPath $($ISS_Application_path) -type Application -ApplicationPool $($App_Pool_Name)



## Enable and Diable the Authentications

Set-WebConfigurationProperty -Filter "/system.webServer/security/authentication/windowsAuthentication" -Name Disabled -Value False -PSPath $IIS_webApp_path
Set-WebConfigurationProperty -Filter "/system.webServer/security/authentication/AnonymousAuthentication" -Name Disabled -Value False -PSPath $IIS_webApp_path
Set-WebConfigurationProperty -Filter "/system.webServer/security/authentication/BasicAuthentication" -Name Enabled -Value True -PSPath $IIS_webApp_path



