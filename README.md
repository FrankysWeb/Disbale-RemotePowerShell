# Disable-RemotePowerShell.ps1
This script disables RemotePowerShell for all users except members of a specific AD group.

## Usage
- Create an AD group e.g. "AllowRemotePowerShell".
- Change line 2 of this script to your AD group
- Run this script:

```
.\Disable-RemotePowerShell.ps1
```

## Create Windows Scheduler Task
- Create a Windows Scheduler Task to run this script every day

## Tested Exchange / Windows Server Versions
 - Exchange Server 2019
 - Windows Server 2022

## Website
 [FrankysWeb](https://www.frankysweb.de/)