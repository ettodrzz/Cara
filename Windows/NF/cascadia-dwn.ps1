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
    Expand-Archive -Path "$Env:Temp\CaskaydiaCove.zip" -DestinationPath "$Home\Downloads\CaskaydiaCove" -Force
}

# ┌───────────┐
# │ Execution │
# └───────────┘

try
{
    Write-Host "Downloading Caskaydia Nerd Font..."
    Download-Fonts
    Write-Host "$GreenSign" "Done."
}
catch
{
    Write-Host "$RedSign" "Something went wrong."
}