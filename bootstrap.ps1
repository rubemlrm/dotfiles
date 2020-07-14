$profileDir = Split-Path -parent $profile
function Refresh-Environment {
    $locations = 'HKLM:\SYSTEM\CurrentControlSet\Control\Session Manager\Environment',
    'HKCU:\Environment'

    $locations | ForEach-Object {
        $k = Get-Item $_
        $k.GetValueNames() | ForEach-Object {
            $name = $_
            $value = $k.GetValue($_)
            Set-Item -Path Env:\$name -Value $value
        }
    }

    $env:Path = [System.Environment]::GetEnvironmentVariable("Path", "Machine") + ";" + [System.Environment]::GetEnvironmentVariable("Path", "User")
}

Write-Host "Install powershell modules"
#install posh
if (-Not (Get-Module -ListAvailable -Name PSUtil)) {
    Install-Module PSUtil -Scope CurrentUser
}

if (-Not (Get-Module -ListAvailable -Name posh-git)) {
    Install-Module posh-git -Scope CurrentUser
}
if (-Not (Get-Module -ListAvailable -Name oh-my-posh)) {
    Install-Module oh-my-posh -Scope CurrentUser
}

If (-Not (Get-Module -ListAvailable -Name PSWindowsUpdate)) {
    Install-Module PSWindowsUpdate -Scope CurrentUser
}

if(-Not (Test-Path $home)) {
    New-Item $profileDir -ItemType Directory -Force -ErrorAction SilentlyContinue
}

Write-Host "Restore powershell scripts"
#Copy base powershell
Get-ChildItem -Path ./windows/powershell/* -Include "*.ps1" | ForEach-Object {
    $fileName = $_.BaseName
    New-Item -Itemtype SymbolicLink -Path $profileDir -Name "$fileName.ps1" -Target $_.FullName -Force
}
#Copy powershell alias and functions
New-Item -Itemtype SymbolicLink -Path "${profileDir}/autoload"  -Target "${pwd}/windows/powershell/autoload" -Force
Copy-Item -Path ./shared/** -Destination $home -Include **

#copy window terminal settings
Write-Host "Restore windows terminal settings"
New-Item -Itemtype SymbolicLink -Path "$env:LocalAppData\Packages\Microsoft.WindowsTerminal_8wekyb3d8bbwe\LocalState"  -Target "${pwd}/windows/terminal/" -Force


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
choco install curl                --limit-output
choco install nuget.commandline   --limit-output
choco install git.install         --limit-output
choco install nodejs              --limit-output
choco install python              --limit-output
choco install ruby                --limit-output
choco install bitwarden           --limit-output
choco install filezilla           --limit-output
choco install firefox           --limit-output
choco install 7zip                --limit-output
choco install php                 --limit-output
choco install spotify             --limit-output
choco install notepadplusplus.install --limit-output
choco install vscode -y --limit-output
choco install visualstudiocode-insiders -y --limit-output
#fonts
choco install sourcecodepro       --limit-output
choco install meslolg.dz  --limit-output
# browsers
choco install GoogleChrome        --limit-output; <# pin; evergreen #> choco pin add --name GoogleChrome        --limit-output


Remove-Variable profileDir


