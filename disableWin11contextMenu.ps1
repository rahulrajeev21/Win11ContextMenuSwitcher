$regKeyParentPath = "HKCU:\Software\Classes\CLSID\"
$guid = "{86ca1aa0-34aa-4e8b-a509-50c905bae2a2}"
$regKey = "InprocServer32"
$regKeyPath = Join-Path -Path $regKeyParentPath -ChildPath $guid
$regKeyParamPath = Join-Path -Path $regKeyPath -ChildPath $regKey

function Disable-Win11ContextMenu {
    New-Item –Path $regKeyParentPath –Name $guid
    New-Item –Path $regKeyPath –Name $regKey
    New-ItemProperty -Path $regKeyParamPath -Name "(Default)" -Value " " -PropertyType "String"
    stop-process -name explorer –force
    Write-Host "Win11 context menu disabled" 
}

function Enable-Win11ContextMenu {
    Remove-Item -Path $regKeyPath -Recurse
    stop-process -name explorer –force
    Write-Host "Win11 context menu enabled" 
}

function Show-Options {
    Clear-Host;
    Write-Host "Enable or Disable Win11 Context Menu (press q to exit):"
    Write-Host "1. Disable Win11 context menu `n2. Enable Win11 context menu"
    return Read-Host
}

do {
    $option = Show-Options
    switch ($option) {
        1 { Disable-Win11ContextMenu; Break }
        2 { Enable-Win11ContextMenu; Break }
    }
}
until ($option -eq 'q')


