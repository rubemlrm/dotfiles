$chocoUtils = @("bitwarden", "7zip", "vlc", "wireshark", "steam")
$chocoDevelopmentUtils = @("docker-desktop", "notepadplusplus.install", "vscode", "curl", "nuget.commandline", "git.install")
$chocoLanguageSDK = @("nodejs", "python", "ruby", "php", "dotnetcore-sdk")
$chocoFonts = @("sourcecodepro", "meslolg.dz")
$chocoBrowsers = @("GoogleChrome", "firefox")

 function chocoInstallHelper {
    Param ($softwareList)
    foreach ($item in $softwareList) {
        Write-Output $item
        choco install $item --limit-output
    }
}

Write-Host "Installing Desktop Utilities..." -ForegroundColor "Yellow"
Set-ExecutionPolicy Bypass -Scope Process -Force; [System.Net.ServicePointManager]::SecurityProtocol = [System.Net.ServicePointManager]::SecurityProtocol -bor 3072; iwr https://chocolatey.org/install.ps1 -UseBasicParsing | iex
# Make `refreshenv` available right away, by defining the $env:ChocolateyInstall
# variable and importing the Chocolatey profile module.
# Note: Using `. $PROFILE` instead *may* work, but isn't guaranteed to.
$env:ChocolateyInstall = Convert-Path "$((Get-Command choco).Path)\..\.."
Import-Module "$env:ChocolateyInstall\helpers\chocolateyProfile.psm1"

# refreshenv is now an alias for Update-SessionEnvironment
# (rather than invoking refreshenv.cmd, the *batch file* for use with cmd.exe)
# This should make git.exe accessible via the refreshed $env:PATH, so that it
# can be called by name only.
refreshenv
choco feature enable -n=allowGlobalConfirmation

# system and cli

Write-Information "Installing Languages SDK's"
chocoInstallHelper $chocoLanguageSDK
Write-Information "Installing Utils"
chocoInstallHelper $chocoUtils
Write-Information "Installing development utils"
chocoInstallHelper $chocoDevelopmentUtils
Write-Information "Installing  Fonts"
chocoInstallHelper $chocoFonts
Write-Information "Installing  Browsers"
chocoInstallHelper $chocoBrowsers