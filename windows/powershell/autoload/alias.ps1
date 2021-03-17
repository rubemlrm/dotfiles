#reload powershell alias
Set-Alias reload Reload-Powershell
# Create a new directory and enter it
Set-Alias mkd CreateAndSet-Directory
# Determine size of a file or total size of a directory
Set-Alias fs Get-DiskUsage
# Empty the Recycle Bin on all drives
Set-Alias emptytrash Empty-RecycleBin

# Cleanup old files all drives
Set-Alias cleandisks Clean-Disks
# Missing Bash aliases
Set-Alias time Measure-Command
# http://xkcd.com/530/
Set-Alias mute Set-SoundMute
Set-Alias unmute Set-SoundUnmute

# Navigation Shortcuts
${function:desktop} = { Set-Location ~\Desktop }
${function:docs} = { Set-Location ~\Documents }
${function:downloads} = { Set-Location ~\Downloads }

#network
${function:getPublicIp} = { (Invoke-WebRequest -uri "http://ifconfig.me/ip").Content }
