
if (-not (Test-Path -Path '${HOME}\scoop')) {
    Write-Information "Installing scoop"
    iwr -useb get.scoop.sh | iex
    scoop checkup
}



Write-Information "Installing scoop packages"
scoop install 7zip
scoop install sudo
sudo Add-MpPreference -ExclusionPath '${HOME}\scoop'
sudo Add-MpPreference -ExclusionPath 'C:\ProgramData\scoop'
sudo Set-ItemProperty 'HKLM:\SYSTEM\CurrentControlSet\Control\FileSystem' -Name 'LongPathsEnabled' -Value 1

scoop bucket add extras
scoop install php
scoop install nano
# Fonts
scoop bucket add nerd-fonts
sudo scoop install FiraCode
sudo scoop install FiraCode-NF
sudo scoop install Cascadia-Code
