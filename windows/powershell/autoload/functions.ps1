# Reload the Shell
#PSSCRIPTANALYZER -PSUseApprovedVerbs
function Get-Session {
    $newProcess = new-object System.Diagnostics.ProcessStartInfo "PowerShell";
    $newProcess.Arguments = "-nologo";
    [System.Diagnostics.Process]::Start($newProcess);
    exit
}

# Common Editing needs
function Edit-Hosts { & "$(if($null -ne $env:EDITOR)  {$env:EDITOR } else { 'notepad' }) $env:windir\system32\drivers\etc\hosts" }
function Edit-Profile { & "$(if($null -ne $env:EDITORl)  {$env:EDITOR } else { 'notepad' }) $profile" }

# Sudo
function sudo() {
    if ($args.Length -eq 1) {
        start-process $args[0] -verb "runAs"
    }
    if ($args.Length -gt 1) {
        start-process $args[0] -ArgumentList $args[1..$args.Length] -verb "runAs"
    }
}

#PSSCRIPTANALYZER -PSUseApprovedVerbs
function Get-ENV {
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

function Which($name) { Get-Command $name -ErrorAction SilentlyContinue | Select-Object Definition }
function Touch($file) { "" | Out-File $file -Encoding ASCII }
function Show-Wlan { Param([string]$a)netsh.exe wlan show profile name=$a key=clear }

function Update-DotFiles {
    Set-Location $env:dotfilesDir
    git pull origin main
}
