Import-Module posh-git
Import-Module oh-my-posh
Set-PoshPrompt -Theme Sorin

$profileDir = Split-Path -parent $profile
# load all 'autoload' scripts
Get-ChildItem "${profileDir}\autoload\*.ps1" |  ForEach-Object -Process { .$_ }
