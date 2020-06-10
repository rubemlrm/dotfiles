Import-Module posh-git
Import-Module oh-my-posh
Set-Theme Honukai

$profileDir = Split-Path -parent $profile
# load all 'autoload' scripts
Get-ChildItem "${profileDir}\autoload\*.ps1" | % { .$_ }