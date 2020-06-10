Import-Module posh-git
Import-Module oh-my-posh
Set-Theme Honukai

$profileDir = Split-Path -parent $profile
# load all 'autoload' scripts
Get-ChildItem "${profileDir}\*.ps1" -Exclude "profile.ps1", "Microsoft.PowerShell_profile.ps1" | % { .$_ }
