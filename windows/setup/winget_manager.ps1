
$wingetUtilsPackages = @(
    "VideloLan.VLC"
    "7zip.7zip"
    "Valve.Steam",
    "Bitwarden.Bitwarden",
    "Google.Chrome",
    "Google.ChromeBeta"
    "NordVPN.NordVPN",
    "Microsoft.RemoteDesktopClient"
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
    "ApacheFriends.Xampp",
    "JetBrains.PHPStorm",
    "dbeaver.dbeaver"
    "TimKosse.FileZillaClient"
    "JetBrains.PHPStorm",
    "Arduino.Arduino",
    "gerardog.gsudo"
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
