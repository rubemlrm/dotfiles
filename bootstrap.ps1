# Set execution policy to remote signed
Set-ExecutionPolicy RemoteSigned
$dotfilesDir = Get-Location
$profileDir = Split-Path -parent $profile
[System.Environment]::SetEnvironmentVariable('dotfilesDir', $dotfilesDir , [System.EnvironmentVariableTarget]::User)

Write-Information "Install powershell modules"
#install posh
if (-Not (Get-Module -ListAvailable -Name PSUtil)) {
    Install-Module PSUtil -Scope CurrentUser -Confirm:$False -Force
}

if (-Not (Get-Module -ListAvailable -Name posh-git)) {
    Install-Module posh-git -Scope CurrentUser -Confirm:$False -Force
}
if (-Not (Get-Module -ListAvailable -Name oh-my-posh)) {
    Install-Module oh-my-posh -Scope CurrentUser -AllowPrerelease -Confirm:$False -Force
}

If (-Not (Get-Module -ListAvailable -Name PSWindowsUpdate)) {
    Install-Module PSWindowsUpdate -Scope CurrentUser -Confirm:$False -Force
}
New-Item $profileDir -ItemType Directory -Force -ErrorAction SilentlyContinue


Write-Information "Restore powershell scripts"
#Copy base powershell
Get-ChildItem -Path ./configs/powershell/* -Include "*.ps1" | ForEach-Object {
    $fileName = $_.BaseName
    New-Item -Itemtype SymbolicLink -Path $profileDir -Name "$fileName.ps1" -Target $_.FullName -Force
}
#Copy powershell alias and functions
New-Item -Itemtype SymbolicLink -Path "${profileDir}/autoload"  -Target "${pwd}/windows/powershell/autoload" -Force
#Copy Git configs
New-Item -Itemtype SymbolicLink -Path "${profileDir}/.gitconfig"  -Target "${pwd}/configs/git/gitconfig" -Force
New-Item -Itemtype SymbolicLink -Path "${profileDir}/.gitattributes"  -Target "${pwd}/configs/git/gitattributes" -Force
New-Item -Itemtype SymbolicLink -Path "${profileDir}/.gitignore"  -Target "${pwd}/configs/git/gitignore" -Force

#Copy npm configs
New-Item -Itemtype SymbolicLink -Path "${profileDir}/.npmrc"  -Target "${pwd}/configs/npm/npmrc" -Force


#copy window terminal settings
Write-Information "Restore windows terminal settings"
New-Item -Itemtype SymbolicLink -Path "$env:LocalAppData\Packages\Microsoft.WindowsTerminal_8wekyb3d8bbwe\LocalState"  -Target "${pwd}/configs/windowsTerminal/" -Force

Remove-Variable profileDir
