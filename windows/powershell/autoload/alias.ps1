# Navigation Shortcuts
${function:desktop} = { Set-Location ~\Desktop }
${function:docs} = { Set-Location ~\Documents }
${function:downloads} = { Set-Location ~\Downloads }

#network
${function:getPublicIp} = { (Invoke-WebRequest -uri "http://ifconfig.me/ip").Content }
