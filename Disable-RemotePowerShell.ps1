#Allowed AD Group for RemotePowerShell:
$AllowedGroup = "AllowRemotePowerShell"


$AllUsers = Get-Mailbox -ResultSize Unlimited | Get-User -ResultSize Unlimited | Select UserPrincipalName, RemotePowerShellEnabled | Where {$_.RemotePowerShellEnabled -eq $true}
$AllowedUsers = Get-ADGroupMember $AllowedGroup -Recursive | ForEach-Object {Get-User -Identity $_.SamAccountName | Select UserPrincipalName, RemotePowerShellEnabled}

#Enable RemotePowerShell for allowed Users
foreach ($AllowedUser in $AllowedUsers) {
	if ($AllowedUser.RemotePowerShellEnabled -eq $False) {
		Set-User $AllowedUser.UserPrincipalName -RemotePowerShellEnabled $true
	}
}

#Disable RemotePowerShell for all Users
foreach ($User in $AllUsers) {
	if ($AllowedUsers.UserPrincipalName -notcontains $User.UserPrincipalName) {
		Set-User $User.UserPrincipalName -RemotePowerShellEnabled $false
	}
}

#Display RemotePowerSthell State
$RemotePowerShellState = Get-Mailbox -ResultSize Unlimited | Get-User -ResultSize Unlimited | Select UserPrincipalName, RemotePowerShellEnabled
$RemotePowerShellState
