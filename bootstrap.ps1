# Set execution policy to remote signed
Set-ExecutionPolicy RemoteSigned
$dotfilesDir = Get-Location
$profileDir = Split-Path -parent $profile
[System.Environment]::SetEnvironmentVariable('dotfilesDir', $dotfilesDir , [System.EnvironmentVariableTarget]::User)

Write-Information "Install powershell modules"
#install posh
if (-Not (Get-Module -ListAvailable -Name PSUtil)) {
    Install-Module PSUtil -Scope CurrentUser
}

if (-Not (Get-Module -ListAvailable -Name posh-git)) {
    Install-Module posh-git -Scope CurrentUser
}
if (-Not (Get-Module -ListAvailable -Name oh-my-posh)) {
    Install-Module oh-my-posh -Scope CurrentUser -AllowPrerelease
}

If (-Not (Get-Module -ListAvailable -Name PSWindowsUpdate)) {
    Install-Module PSWindowsUpdate -Scope CurrentUser
}
New-Item $profileDir -ItemType Directory -Force -ErrorAction SilentlyContinue


Write-Information "Restore powershell scripts"
#Copy base powershell
Get-ChildItem -Path ./configs/powershell/* -Include "*.ps1" | ForEach-Object {
    $fileName = $_.BaseName
    New-Item -Itemtype SymbolicLink -Path $profileDir -Name "$fileName.ps1" -Target $_.FullName -Force
}
#Copy powershell alias and functions
New-Item -Itemtype SymbolicLink -Path "${profileDir}/autoload"  -Target "${pwd}/configs/powershell/autoload" -Force
#Copy-Item -Path ./shared/** -Destination $home -Include **

#copy window terminal settings
Write-Information "Restore windows terminal settings"
New-Item -Itemtype SymbolicLink -Path "$env:LocalAppData\Packages\Microsoft.WindowsTerminal_8wekyb3d8bbwe\LocalState"  -Target "${pwd}/configs/terminal/" -Force

Remove-Variable profileDir
