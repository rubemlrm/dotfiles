
$chocoPackages = @("curl", "nuget.commandline", "php", "sourcecodepro", "meslolg.dz")
$wingetPackages = @(
    "Microsoft.Powershell"
    "Microsoft.PowerToys",
    "Microsoft.WindowsTerminal",
    "Debian.Debian",
    "Canonical.Ubuntu"
    "Microsoft.VisualStudioCode",
    "vim.vim",
    "Git.Git",
    "Notepad++.Notepad++",
    "VideloLan.VLC"
    "7zip.7zip"
    "WiresharkFoundation.Wireshark",
    "Valve.Steam",
    "Bitwarden.Bitwarden",
    "Docker.DockerDesktop"
    "OpenJS.NodeJS",
    "Python.Python",
    "RubyInstallerTeam.RubyWithDevKit",
    "Microsoft.dotnet",
    "Google.Chrome",
    "Google.ChromeBeta"
    "Mozilla.FirefoxDeveloperEdition"
    "Google.BackupAndSync"
    )

 function chocoInstallHelper {
    Param ($softwareList)
    foreach ($item in $softwareList) {
        choco install $item --limit-output
    }
}

function wingetInstallHelper {
    Param ($softwareList)
    foreach ($item in $softwareList) {
        winget install $item
    }
}

refreshenv
choco feature enable -n=allowGlobalConfirmation

# system and cli
Write-Information "Installing Choco Packages"
chocoInstallHelper $chocoPackages
Write-Information "Install packages with winget"
wingetInstallHelper $wingetPackages
Write-Information "Install npm packages"
npm install -g eslint standard
Write-Information "Install php packages"
composer global require phpmd/phpmd "squizlabs/php_codesniffer=*"
