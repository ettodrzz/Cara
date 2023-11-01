# ┌───────────┐
# │ Variables │
# └───────────┘

$GreenSign = "$([char]0x1b)[92;49m$([char]0x2022)$([char]0x1b)[0m"
$RedSign = "$([char]0x1b)[91;49m$([char]0x2022)$([char]0x1b)[0m"

# ┌───────────┐
# │ Functions │
# └───────────┘

# ┌─ Gets the name of the latest version of the Nerd Font repository.
Function Get-RepoVersion
{
    foreach ($GitLatestTag in (Invoke-WebRequest -Uri "https://github.com/ryanoasis/nerd-fonts/releases/latest" -UseBasicParsing).Links.Href)
    {
        if ($GitLatestTag -match "/releases/tag")
        {
            return $GitLatestTag -replace "/ryanoasis/nerd-fonts/releases/tag/v", ""
        }
    }
}
# ┌─ Downloads the latest version of Caskaydia Font from the Nerd Font repository.
Function Download-Fonts
{
    $RepoVersion = Get-RepoVersion
    Invoke-WebRequest -Uri "https://github.com/ryanoasis/nerd-fonts/releases/download/v$RepoVersion/CascadiaCode.zip" -OutFile "$Env:Temp\CaskaydiaCove.zip"
    Expand-Archive -Path "$Env:Temp\CaskaydiaCove.zip" -DestinationPath "$Env:Temp\CaskaydiaCove" -Force 
}
# ┌─ Moves and registers the files
Function Install-Fonts
{
    New-Item -Path "$Env:LocalAppData\Microsoft\Windows\Fonts" -Name "CaskaydiaCove" -ItemType Directory -Force | Out-Null
    foreach ($PropoFont in (Get-ChildItem -Path $Env:Temp\CaskaydiaCove).Name)
    {
        if ($PropoFont -match "Propo")
        {
            Move-Item -Path $Env:Temp\CaskaydiaCove\$PropoFont -Destination $Env:LocalAppData\Microsoft\Windows\Fonts\CaskaydiaCove\$PropoFont
            [Microsoft.Win32.Registry]::SetValue("HKEY_CURRENT_USER\SOFTWARE\Microsoft\Windows NT\CurrentVersion\Fonts", $PropoFont, "$Env:LocalAppData\Microsoft\Windows\Fonts\CaskaydiaCove\$PropoFont", [Microsoft.Win32.RegistryValueKind]::String)
        }
    }
    Move-Item -Path $Env:Temp\CaskaydiaCove\LICENSE -Destination $Env:LocalAppData\Microsoft\Windows\Fonts\CaskaydiaCove\LICENSE
}

# ┌───────────┐
# │ Execution │
# └───────────┘

try
{
    Write-Host "Caskaydia Nerd Font"
    Write-Host "-------------------"
    Write-Host "Downloading..."
    Download-Fonts
    Write-Host "Installing..."
    Install-Fonts
    Write-Host "$GreenSign" "Done."
}
catch
{
    Write-Host "$RedSign" "Something went wrong."
}