# To disable defender, copy `nodefender.cmd` to:
# C:\Users\[Your User]\AppData\Roaming\Microsoft\Windows\Start Menu\Programs\Startup
# or hit WinKey+R and type `shell:startup` to find this folder
Set-MpPreference -DisableRealtimeMonitoring $true
