Write-Information "Enable WSL"
dism.exe /online /enable-feature /featurename:Microsoft-Windows-Subsystem-Linux /all /norestart
dism.exe /online /enable-feature /featurename:VirtualMachinePlatform /all /norestart
wsl --set-default-version 2


Write-Information "install chocolatey"
Set-ExecutionPolicy Bypass -Scope Process -Force; [System.Net.ServicePointManager]::SecurityProtocol = [System.Net.ServicePointManager]::SecurityProtocol -bor 3072; iex ((New-Object System.Net.WebClient).DownloadString('https://chocolatey.org/install.ps1'))
Write-Information "Install chocolatey packages"
choco feature enable -n=allowGlobalConfirmation
choco install php composer sourcecodepro --limit-output

$wingetUtilsPackages = @(
    "VideloLan.VLC"
    "7zip.7zip"
    "Valve.Steam",
    "Bitwarden.Bitwarden",
    "Google.Chrome",
    "Google.ChromeBeta"
    "Google.BackupAndSync",
    "NordVPN.NordVPN"
)

$wingetFontPackages = @(
    "SourceFoundry.HackFonts"
)

$wingetWSLPackages = @(
    "Debian.Debian",
    "Canonical.Ubuntu"
)

$wingetLanguagesSDK = @(
    "OpenJS.NodeJS",
    "Python.Python",
    "RubyInstallerTeam.RubyWithDevKit",
    "Microsoft.dotnet"
)

$wingetDevelopmentTools = @(
    "Microsoft.Powershell"
    "Microsoft.PowerToys",
    "Microsoft.WindowsTerminal",
    "Microsoft.VisualStudioCode",
    "vim.vim",
    "Git.Git",
    "Notepad++.Notepad++",
    "Docker.DockerDesktop"
    "Mozilla.FirefoxDeveloperEdition"
    "WiresharkFoundation.Wireshark",
    "Microsoft.VisualStudio.Community",
    "ApacheFriends.Xampp"
)



function wingetInstallHelper {
    Param ($softwareList)
    foreach ($item in $softwareList) {
        winget install $item
    }
}

refreshenv
# system and cli
Write-Information "Install utils packages with winget"
wingetInstallHelper $wingetUtilsPackages
Write-Information "Install fonts packages with winget"
wingetInstallHelper $wingetFontPackages
Write-Information "Install wsl packages with winget"
wingetInstallHelper $wingetWSLPackages
Write-Information "Install languages SDK packages with winget"
wingetInstallHelper $wingetLanguagesSDK
Write-Information "Install development tools SDK packages with winget"
wingetInstallHelper $wingetDevelopmentTools
Write-Information "Install npm packages"
npm install -g eslint standard
Write-Information "Install php packages"
composer global require phpmd/phpmd "squizlabs/php_codesniffer=*"
