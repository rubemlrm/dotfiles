
$profileDir = Split-Path -parent $profile

#install posh
if (-Not (Get-Module -ListAvailable -Name posh-git)) {
    Install-Module posh-git -Scope CurrentUser
}
if (-Not (Get-Module -ListAvailable -Name oh-my-posh)) {
    Install-Module oh-my-posh -Scope CurrentUser
}

if(-Not (Test-Path $home)) {
    New-Item $profileDir -ItemType Directory -Force -ErrorAction SilentlyContinue
}

#Copy base powershell
Get-ChildItem -Path ./windows/powershell/* -Include "*.ps1" | ForEach-Object {
    $fileName = $_.BaseName
    New-Item -Itemtype SymbolicLink -Path $profileDir -Name "$fileName.ps1" -Target $_.FullName -Force
}
#Copy powershell alias and functions
$powershellAutoLoad = "${profileDir}\autoload"
Get-ChildItem -Path ./windows/powershell/autoload/* -Include "*.ps1" | ForEach-Object {
    $fileName = $_.BaseName
    New-Item -Itemtype SymbolicLink -Path $powershellAutoLoad -Name "$fileName.ps1" -Target $_.FullName -Force
}
Copy-Item -Path ./shared/** -Destination $home -Include **

Remove-Variable profileDir
Remove-Variable powershellAutoLoad