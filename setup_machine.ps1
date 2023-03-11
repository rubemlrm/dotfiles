##### FUNCTIONS
# Hide Task View button
Function HideTaskView {
    Write-Information "Hiding Task View button..."
    sudo Set-ItemProperty -Path "HKCU:\Software\Microsoft\Windows\CurrentVersion\Explorer\Advanced" -Name "ShowTaskViewButton" -Type DWord -Value 0
}
# Show small icons in taskbar
Function ShowSmallTaskbarIcons {
    Write-Information "Showing small icons in taskbar..."
    sudo Set-ItemProperty -Path "HKCU:\Software\Microsoft\Windows\CurrentVersion\Explorer\Advanced" -Name "TaskbarSmallIcons" -Type DWord -Value 1
}

# Hide Taskbar People icon
Function HideTaskbarPeopleIcon {
    Write-Information "Hiding People icon..."
    If (!(Test-Path "HKCU:\Software\Microsoft\Windows\CurrentVersion\Explorer\Advanced\People")) {
        sudo New-Item -Path "HKCU:\Software\Microsoft\Windows\CurrentVersion\Explorer\Advanced\People" | Out-Null
    }
    sudo Set-ItemProperty -Path "HKCU:\Software\Microsoft\Windows\CurrentVersion\Explorer\Advanced\People" -Name "PeopleBand" -Type DWord -Value 0
}
# Show all tray icons
Function ShowTrayIcons {
    Write-Information "Showing all tray icons..."
    If (!(Test-Path "HKCU:\Software\Microsoft\Windows\CurrentVersion\Policies\Explorer")) {
        sudo New-Item -Path "HKCU:\Software\Microsoft\Windows\CurrentVersion\Policies\Explorer" | Out-Null
    }
    sudo Set-ItemProperty -Path "HKCU:\Software\Microsoft\Windows\CurrentVersion\Policies\Explorer" -Name "NoAutoTrayNotify" -Type DWord -Value 1
}
# Set Control Panel view to Small icons (Classic)
Function SetControlPanelSmallIcons {
    Write-Information "Setting Control Panel view to small icons..."
    If (!(Test-Path "HKCU:\Software\Microsoft\Windows\CurrentVersion\Explorer\ControlPanel")) {
        sudo New-Item -Path "HKCU:\Software\Microsoft\Windows\CurrentVersion\Explorer\ControlPanel" | Out-Null
    }
    sudo Set-ItemProperty -Path "HKCU:\Software\Microsoft\Windows\CurrentVersion\Explorer\ControlPanel" -Name "StartupPage" -Type DWord -Value 1
    sudo Set-ItemProperty -Path "HKCU:\Software\Microsoft\Windows\CurrentVersion\Explorer\ControlPanel" -Name "AllItemsIconView" -Type DWord -Value 1
}

Function InstallHyperV {
    Write-Information "Installing Hyper-V..."
    If ((Get-CimInstance -Class "Win32_OperatingSystem").ProductType -eq 1) {
        sudo Get-WindowsOptionalFeature -Online | Where-Object { $_.FeatureName -eq "Microsoft-Hyper-V-All" } | Enable-WindowsOptionalFeature -Online -NoRestart -WarningAction SilentlyContinue | Out-Null
    }
    Else {
        sudo Install-WindowsFeature -Name "Hyper-V" -IncludeManagementTools -WarningAction | Out-Null
    }
}

function EnableDarkMode {
    # Enable Windows Dark Theme
    Set-ItemProperty -Path "HKCU:\Software\Microsoft\Windows\CurrentVersion\Themes\Personalize" -type "Dword" -Name "SystemUsesLightTheme" -Value "0"
    # Enable App Dark Theme
    Set-ItemProperty -Path "HKCU:\Software\Microsoft\Windows\CurrentVersion\Themes\Personalize" -type "Dword" -Name "AppsUseLightTheme" -Value "0"
}

function EnableGeneralUsability {
    # Default Explorer view This PC
    Set-ItemProperty -Path "HKCU:\SOFTWARE\Microsoft\Windows\CurrentVersion\Explorer\Advanced" -type "Dword" -Name "LaunchTo" -Value "1"
    # Show file extensions
    Set-ItemProperty -Path "HKCU:\Software\Microsoft\Windows\CurrentVersion\Explorer\Advanced" -type "Dword" -Name "HideFileExt"  -Value "0"
}

# Uninstall default Microsoft applications
Function UninstallBloat {
    Write-Information "Uninstalling default Microsoft applications..."
    $packages = @(
        "Microsoft.3DBuilder",
        "Microsoft.AppConnector",
        "Microsoft.BingFinance",
        "Microsoft.BingFoodAndDrink",
        "Microsoft.BingHealthAndFitness",
        "Microsoft.BingMaps",
        "Microsoft.BingNews",
        "Microsoft.BingSports",
        "Microsoft.BingTranslator",
        "Microsoft.BingTravel",
        "Microsoft.BingWeather",
        "Microsoft.CommsPhone",
        "Microsoft.ConnectivityStore",
        "Microsoft.FreshPaint",
        "Microsoft.GetHelp",
        "Microsoft.Getstarted",
        "Microsoft.HelpAndTips",
        "Microsoft.Media.PlayReadyClient.2",
        "Microsoft.Messaging",
        "Microsoft.Microsoft3DViewer",
        "Microsoft.MicrosoftOfficeHub",
        "Microsoft.MicrosoftPowerBIForWindows",
        "Microsoft.MicrosoftSolitaireCollection",
        "Microsoft.MicrosoftStickyNotes",
        "Microsoft.MinecraftUWP",
        "Microsoft.MixedReality.Portal",
        "Microsoft.MoCamera",
        "Microsoft.MSPaint",
        "Microsoft.NetworkSpeedTest",
        "Microsoft.OfficeLens",
        "Microsoft.Office.OneNote",
        "Microsoft.Office.Sway",
        "Microsoft.OneConnect",
        "Microsoft.People",
        "Microsoft.Print3D",
        "Microsoft.Reader",
        "Microsoft.RemoteDesktop",
        "Microsoft.SkypeApp",
        "Microsoft.Todos",
        "Microsoft.Wallet",
        "Microsoft.WebMediaExtensions",
        "Microsoft.Whiteboard",
        "Microsoft.WindowsAlarms",
        "Microsoft.WindowsCamera",
        "microsoft.windowscommunicationsapps",
        "Microsoft.WindowsFeedbackHub",
        "Microsoft.WindowsMaps",
        "Microsoft.WindowsPhone",
        "Microsoft.Windows.Photos",
        "Microsoft.WindowsReadingList",
        "Microsoft.WindowsScan",
        "Microsoft.WindowsSoundRecorder",
        "Microsoft.WinJS.1.0",
        "Microsoft.WinJS.2.0",
        "Microsoft.YourPhone",
        "Microsoft.ZuneMusic",
        "Microsoft.ZuneVideo",
        "Microsoft.Advertising.Xaml",
        "2414FC7A.Viber",
        "41038Axilesoft.ACGMediaPlayer",
        "46928bounde.EclipseManager",
        "4DF9E0F8.Netflix",
        "64885BlueEdge.OneCalendar",
        "7EE7776C.LinkedInforWindows",
        "828B5831.HiddenCityMysteryofShadows",
        "89006A2E.AutodeskSketchBook",
        "9E2F88E3.Twitter",
        "A278AB0D.DisneyMagicKingdoms",
        "A278AB0D.DragonManiaLegends",
        "A278AB0D.MarchofEmpires",
        "ActiproSoftwareLLC.562882FEEB491",
        "AD2F1837.GettingStartedwithWindows8",
        "AD2F1837.HPJumpStart",
        "AD2F1837.HPRegistration",
        "AdobeSystemsIncorporated.AdobePhotoshopExpress",
        "Amazon.com.Amazon",
        "C27EB4BA.DropboxOEM",
        "CAF9E577.Plex",
        "CyberLinkCorp.hs.PowerMediaPlayer14forHPConsumerPC",
        "D52A8D61.FarmVille2CountryEscape",
        "D5EA27B7.Duolingo-LearnLanguagesforFree",
        "DB6EA5DB.CyberLinkMediaSuiteEssentials",
        "DolbyLaboratories.DolbyAccess",
        "Drawboard.DrawboardPDF",
        "Facebook.Facebook",
        "Fitbit.FitbitCoach",
        "flaregamesGmbH.RoyalRevolt2",
        "GAMELOFTSA.Asphalt8Airborne",
        "KeeperSecurityInc.Keeper",
        "king.com.BubbleWitch3Saga",
        "king.com.CandyCrushFriends",
        "king.com.CandyCrushSaga",
        "king.com.CandyCrushSodaSaga",
        "king.com.FarmHeroesSaga",
        "Nordcurrent.CookingFever",
        "PandoraMediaInc.29680B314EFC2",
        "PricelinePartnerNetwork.Booking.comBigsavingsonhot",
        "SpotifyAB.SpotifyMusic",
        "ThumbmunkeysLtd.PhototasticCollage",
        "WinZipComputing.WinZipUniversal",
        "XINGAG.XING"
    )
    foreach ($item in $packages) {
        Get-AppxPackage $item | Remove-AppxPackage
    }
}
function WingetInstallHelper {
    $wingetPackages = @(
        "7zip.7zip",
        "Adobe.Acrobat.Reader.64-bit",
        "ArduinoSA.IDE.stable",
        "Bitwarden.Bitwarden",
        "dbeaver.dbeaver",
        "Docker.DockerDesktop",
        "File-New-Project.EarTrumpet",
        "Git.Git",
        "GitHub.cli",
        "GitHub.GitHubDesktop",
        "GnuPG.GnuPG",
        "GoLang.Go.1.19",
        "Insomnia.Insomnia",
        "Insomnia.InsomniaDesigner",
        "JanDeDobbeleer.OhMyPosh",
        "JetBrains.IntelliJIDEA.Ultimate",
        "Jetbrains.PHPStorm",
        "LINQPad.LINQPad6",
        "Mega.MEGASync",
        "Microsoft.dotnet",
        "Microsoft.Powershell",
        "Microsoft.PowerToys",
        "Microsoft.RemoteDesktopClient",
        "Microsoft.VisualStudio.Community",
        "Microsoft.VisualStudioCode.Insiders",
        "Microsoft.WindowsTerminal",
        "Mozilla.Firefox.DeveloperEdition",
        "Notepad++.Notepad++",
        "OpenJS.NodeJS",
        "9PJPW5LDXLZ5",
        "RubyInstallerTeam.RubyWithDevKit",
        "SourceFoundry.HackFonts",
        "suse.RancherDesktop",
        "TimKosse.FileZillaClient",
        "Valve.Steam",
        "VideloLan.VLC",
        "vim.vim",
        "WhatsApp.WhatsApp",
        "WinDirStat.WinDirStat",
        "WiresharkFoundation.Wireshark",
        "Yarn.Yarn"
    )
    Write-Information "Install packages with winget"
    foreach ($item in $wingetPackages) {
        Write-Information "Installing package: ${item}"
        winget install --silent --Id $item
    }
}
function SetupScoop() {
    Write-Information "Install packages with Scoop"
    if (-not (Test-Path -LiteralPath '${HOME}\scoop')) {
        Write-Information "Installing scoop"

        Invoke-WebRequest get.scoop.sh -OutFile scoop.ps1
        ./scoop.ps1
        scoop checkup
    }
    scoop install 7zip
    scoop install sudo
    sudo Add-MpPreference -ExclusionPath '${HOME}\scoop'
    sudo Add-MpPreference -ExclusionPath 'C:\ProgramData\scoop'
    sudo Set-ItemProperty 'HKLM:\SYSTEM\CurrentControlSet\Control\FileSystem' -Name 'LongPathsEnabled' -Value 1
    scoop bucket add extras
    scoop bucket add nerd-fonts
    sudo scoop install php nano FiraCode FiraCode-NF Cascadia-Code CascadiaCode-NF-Mono CascadiaCode-NF meslo-nf act
}

Function UnpinStart {
    #https://superuser.com/questions/1068382/how-to-remove-all-the-tiles-in-the-windows-10-start-menu
    #Unpins all tiles from the Start Menu
    Write-Information "Unpinning all tiles from the start menu"
    (New-Object -Com Shell.Application).
    NameSpace('shell:::{4234d49b-0245-4df3-b780-3893943456e1}').
    Items() |
    ForEach-Object { $_.Verbs() } |
    Where-Object { $_.Name -match 'Un.*pin from Start' } |
    ForEach-Object { $_.DoIt() }
}

function EnableWsl() {
    Write-Information "Enable WSL"
    sudo dism.exe /online /enable-feature /featurename:Microsoft-Windows-Subsystem-Linux /all /norestart
    sudo dism.exe /online /enable-feature /featurename:VirtualMachinePlatform /all /norestart
    wsl --install
    winget install --silent --Id Debian.Debian
    winget install --silent --Id Canonical.Ubuntu
    winget install --silent --Id suse.opensuse-leap-42
}

function InstallNpmPackages() {
    Write-Information "install npm packages"
    yarn install -g eslint standard @vue/cli
}

function InstallPythonPackages() {
    Write-Information "install python packages"
    pip install virtualenv cookiecutter ansible
}

# system and cli
UninstallBloat
WingetInstallHelper
SetupScoop
InstallNpmPackages
InstallPythonPackages
EnableWsl
InstallHyperV
#### Visual Tweaks
SetControlPanelSmallIcons
ShowTrayIcons
HideTaskbarPeopleIcon
ShowSmallTaskbarIcons
HideTaskView
EnableDarkMode
EnableGeneralUsability
