Import-Module posh-git
oh-my-posh init pwsh --config 'https://raw.githubusercontent.com/JanDeDobbeleer/oh-my-posh/main/themes/spaceship.omp.json' | Invoke-Expression

$profileDir = Split-Path -parent $profile
# load all 'autoload' scripts
Get-ChildItem "${profileDir}\autoload\*.ps1" |  ForEach-Object -Process { .$_ }
