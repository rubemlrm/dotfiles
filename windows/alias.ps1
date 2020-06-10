#reload powershell alias
Set-Alias reload Reload-Powershell
# Create a new directory and enter it
Set-Alias mkd CreateAndSet-Directory

# Navigation Shortcuts
${function:desktop} = { Set-Location ~\Desktop }
${function:docs} = { Set-Location ~\Documents }
${function:downloads} = { Set-Location ~\Downloads }

#network
${function:getPublicIp} = { (Invoke-WebRequest -uri "http://ifconfig.me/ip").Content }
