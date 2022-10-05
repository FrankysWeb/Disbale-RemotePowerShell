#Allowed AD Group for RemotePowerShell:
$AllowedGroup = "AllowRemotePowerShell"


$AllUsers = get-mailbox -resultsize Unlimited | Get-User -ResultSize Unlimited | select SamAccountName,RemotePowerShellEnabled | where {$_.RemotePowerShellEnabled -eq $true}
$AllowedUsers = Get-ADGroupMember $AllowedGroup -Recursive | ForEach-Object {Get-User -Identity $_.SamAccountName | select SamAccountName,RemotePowerShellEnabled}

#Enable RemotePowerShell for allowed Users
foreach ($AllowedUser in $AllowedUsers) {
	if ($AllowedUser.RemotePowerShellEnabled -eq $False) {
		Set-User $AllowedUser.SamAccountName -RemotePowerShellEnabled $true
	}
}

#Disable RemotePowerShell for all Users
foreach ($User in $AllUsers) {
	if ($AllowedUsers.SamAccountName -notcontains $User.SamAccountName) {
		Set-User $User.SamAccountName -RemotePowerShellEnabled $false
	}
}

#Display RemotePowerShell State
$RemotePowerShellState = get-mailbox -resultsize Unlimited | Get-User -ResultSize Unlimited | select SamAccountName,RemotePowerShellEnabled
$RemotePowerShellState
