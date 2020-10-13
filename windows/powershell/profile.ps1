Import-Module posh-git
Import-Module oh-my-posh
Set-Theme Operator

$profileDir = Split-Path -parent $profile
# load all 'autoload' scripts
Get-ChildItem "${profileDir}\autoload\*.ps1" |  ForEach-Object -Process { .$_ }
