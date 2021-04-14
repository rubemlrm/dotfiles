# Environment
#PSSCRIPTANALYZER -PSUseApprovedVerbs
function Get-env {
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

#PSSCRIPTANALYZER -PSUseApprovedVerbs
function Get-Session {
    $newProcess = new-object System.Diagnostics.ProcessStartInfo "PowerShell";
    $newProcess.Arguments = "-nologo";
    [System.Diagnostics.Process]::Start($newProcess);
    exit
}

# General Configs
function sudo() {
    if ($args.Length -eq 1) {
        start-process $args[0] -verb "runAs"
    }
    if ($args.Length -gt 1) {
        start-process $args[0] -ArgumentList $args[1..$args.Length] -verb "runAs"
    }
}

function Which($name) {
    Get-Command $name -ErrorAction SilentlyContinue | Select-Object Definition
}
function Sync-DotFiles {
    Set-Location $env:dotfilesDir
    git pull origin main
}

# Config Edition
function Edit-Hosts {
    vim --nofork $env:windir\system32\drivers\etc\hosts
}
function Edit-Profile {
    vim --nofork $profile
}

# Shell
function Sync-Powershell {
    $newProcess = new-object System.Diagnostics.ProcessStartInfo "PowerShell";
    $newProcess.Arguments = "-nologo";
    [System.Diagnostics.Process]::Start($newProcess);
    exit
}
# File Management
function Get-DiskUsage([string] $path = (Get-Location).Path) {
    Convert-ToDiskSize `
    ( `
            Get-ChildItem .\ -recurse -ErrorAction SilentlyContinue `
        | Measure-Object -property length -sum -ErrorAction SilentlyContinue
    ).Sum `
        1
}
function Clear-Disks {
    Start-Process "$(Join-Path $env:WinDir 'system32\cleanmgr.exe')" -ArgumentList "/sagerun:6174" -Verb "runAs"
}

function Clear-RecycleBin {
    $RecBin = (New-Object -ComObject Shell.Application).Namespace(0xA)
    $RecBin.Items() | ForEach-Object { Remove-Item $_.Path -Recurse -Confirm:$false }
}
function Touch($file) { "" | Out-File $file -Encoding ASCII }
function Add-Directory([String] $path) {
    New-Item $path -ItemType Directory -ErrorAction SilentlyContinue;
    Set-Location $path
}
# Network
function Show-Wlan {
    Param([string]$a)
    netsh.exe wlan show profile name=$a key=clear
}

# Alias for the above methods
Set-Alias reload Reload-Powershell
Set-Alias mkd CreateAndSet-Directory
Set-Alias fs Get-DiskUsage
Set-Alias emptytrash Clear-RecycleBin
Set-Alias cleandisks Clear-Disks
Set-Alias time Measure-Command
Set-Alias syncDotFiles Sync-DotFiles
