<#
.SYNOPSIS
Git for Windows Manager (v0.6)
.DESCRIPTION
Downloads, updates or removes Git.
MinGit is a simple version of Git, without extra features like Git-Bash and Git-Gui.
Also Moar is included, a really good pager.
Both programs are installed for the current user.
.PARAMETER Remove
Uninstalls Git and Moar.
.LINK
https://github.com/ettodrzz/Cara/blob/main/Windows/Git/git.md
#>

# ┌──────────┐
# │ Contents │
# └──────────┘

# [Parameters] .......................... 44

# [Variables] ........................... 55

# [Functions]
# ├─ Directories 
# │  └┬─ Check-Directories .............. 69
# │   └─ Delete-Directories ............. 77
# ├─ Paths
# │  └┬─ Check-Paths .................... 86
# │   ├─ Add-Paths ...................... 96
# │   └─ Remove-Paths ................... 104
# ├─ Versions
# │  └┬─ Print-LocalVersions ............ 115
# │   └─ Repositories
# │      └┬─ Get-GitRepoVersion ......... 125
# │       └─ Get-MoarRepoVersion ........ 137
# ├─ Downloads
# │  └┬─ Download-Git ................... 154
# │   └─ Download-Moar .................. 163
# └─ Prompt-Continue .................... 172

# [Execution] ........................... 195

# ┌────────────┐
# │ Parameters │
# └────────────┘

Param
(
    [Parameter(ValueFromPipeline)]
    [Alias("R")]
    [Switch]$Remove
)

# ┌───────────┐
# │ Variables │
# └───────────┘

$YellowSign = "$([char]0x1b)[93;49m$([char]0x2022)$([char]0x1b)[0m"
$GreenSign = "$([char]0x1b)[92;49m$([char]0x2022)$([char]0x1b)[0m"
$RedSign = "$([char]0x1b)[91;49m$([char]0x2022)$([char]0x1b)[0m"

# ┌───────────┐
# │ Functions │
# └───────────┘

# ┌ Directories ┐
# └─────────────┘
# ┌─ Checks if the Git and Moar folders already exist in %LocalAppData%\Programs.
Function Check-Directories
{
    if ((Test-Path -Path "$Env:LocalAppData\Programs\Git") -and (Test-Path -Path "$Env:LocalAppData\Programs\Moar"))
    {
        return $True
    }
}
# ┌─ Deletes the Git and Moar folders in %LocalAppData%\Programs.
Function Delete-Directories
{
    Remove-Item -Path "$Env:LocalAppData\Programs\Git" -Recurse -Force
    Remove-Item -Path "$Env:LocalAppData\Programs\Moar" -Recurse -Force
}

# ┌ Paths ┐
# └───────┘
# ┌─ Checks if Git and Moar paths already exist in the current user's Path environment variable.
Function Check-Paths
{
    $IndexPathEnvVar = ((reg query HKCU\Environment /v Path)[2]).LastIndexOf("    ") + 4
    $PathEnvVar = ((reg query HKCU\Environment /v Path)[2]).Substring($IndexPathEnvVar)
    if (($PathEnvVar -match [regex]::Escape("%LocalAppData%\Programs\Git\mingw64\bin")) -and ($PathEnvVar -match [regex]::Escape("%LocalAppData%\Programs\Moar")))
    {
        return $True
    }
}
# ┌─ Adds Git and Moar paths to the current user's Path environment variable.
Function Add-Paths
{
    $IndexPathEnvVar = ((reg query HKCU\Environment /v Path)[2]).LastIndexOf("    ") + 4
    $PathEnvVar = ((reg query HKCU\Environment /v Path)[2]).Substring($IndexPathEnvVar)
    $UpdatedPathEnvVar = $PathEnvVar + "%LocalAppData%\Programs\Git\mingw64\bin;%LocalAppData%\Programs\Moar;"
    [Microsoft.Win32.Registry]::SetValue("HKEY_CURRENT_USER\Environment", "Path", $UpdatedPathEnvVar, [Microsoft.Win32.RegistryValueKind]::ExpandString)
}
# ┌─  Removes Git and Moar paths in the current user's Path environment variable.
Function Remove-Paths
{
    $IndexPathEnvVar = ((reg query HKCU\Environment /v Path)[2]).LastIndexOf("    ") + 4
    $PathEnvVar = ((reg query HKCU\Environment /v Path)[2]).Substring($IndexPathEnvVar)
    $UpdatedPathEnvVar = (($PathEnvVar).Replace("%LocalAppData%\Programs\Git\mingw64\bin;", "")).Replace("%LocalAppData%\Programs\Moar;", "")
    [Microsoft.Win32.Registry]::SetValue("HKEY_CURRENT_USER\Environment", "Path", $UpdatedPathEnvVar, [Microsoft.Win32.RegistryValueKind]::ExpandString)
}

# ┌ Versions ┐
# └──────────┘
# ┌─ Prints the names of the installed versions of Git and Moar.
Function Print-LocalVersions
{
    Write-Host ""
    Write-Host "Installed versions:"
    git --version
    Write-Host "moar $(moar --version)"
}
# ┌ Repository versions ┐
# └─────────────────────┘
# ┌─ Gets the name of the latest version of Git in its repository.
Function Get-GitRepoVersion
{
    foreach ($GitLatestTag in (Invoke-WebRequest -Uri "https://github.com/git-for-windows/git/releases/latest" -UseBasicParsing).Links.Href)
    {
        if ($GitLatestTag -match "/releases/tag")
        {
            return $GitLatestTag -replace "/git-for-windows/git/releases/tag/v", ""
            break
        }
    }
}
# ┌─ Gets the name of the latest version of Moar in its repository.
Function Get-MoarRepoVersion
{
    foreach ($MoarLatestTag in (Invoke-WebRequest -Uri "https://github.com/walles/moar/releases/latest" -UseBasicParsing).Links.Href)
    {
        if ($MoarLatestTag -match "/releases/tag")
        {
            return $MoarLatestTag -replace "/walles/moar/releases/tag/v", ""
            break
        }
    }
}

# ┌ Downloads ┐
# └───────────┘
# ┌─ Downloads the latest version of Git from its repository.
# │  Saves MinGit.zip in %Temp%, then unzips it to %LocalAppData%\Programs\Git.
# │  Restores gitconfig file: So that, Notepad is the editor, Moar is the pager, and "main" is the name of the initial branch.
Function Download-Git
{
    $GitRepoVersion = Get-GitRepoVersion
    Invoke-WebRequest -Uri "https://github.com/git-for-windows/git/releases/download/v$GitRepoVersion/MinGit-$($GitRepoVersion -replace '.windows', '')-64-bit.zip" -OutFile "$Env:Temp\MinGit.zip"
    Expand-Archive -Path "$Env:Temp\MinGit.zip" -DestinationPath "$Env:LocalAppData\Programs\Git" -Force
    Invoke-WebRequest -Uri "https://raw.githubusercontent.com/ettodrzz/Cara/main/Windows/Git/gitconfig" -OutFile "$Env:LocalAppData\Programs\Git\etc\gitconfig"
}
# ┌─ Downloads the latest version of Moar from its repository.
# │  Saves moar.exe and its license in %LocalAppData%\Programs\Moar.
Function Download-Moar
{
    $MoarRepoVersion = Get-MoarRepoVersion
    New-Item -Path "$Env:LocalAppData\Programs\Moar" -ItemType "Directory" -Force | Out-Null
    Invoke-WebRequest -Uri "https://github.com/walles/moar/releases/download/v$MoarRepoVersion/moar-v$MoarRepoVersion-windows-amd64.exe" -OutFile "$Env:LocalAppData\Programs\Moar\moar.exe"
    Invoke-WebRequest -Uri "https://raw.githubusercontent.com/walles/moar/master/LICENSE" -OutFile "$Env:LocalAppData\Programs\Moar\LICENSE.txt"
}

# ┌─ Asks the user if they want to continue with the script.
Function Prompt-Continue
{
    Write-Host "[Y]Yes " -ForegroundColor Yellow -NoNewLine
    Write-Host "[N]No: " -NoNewLine
    do
    {
        $PromptOption = Read-Host
        if (($PromptOption -eq "") -or ($PromptOption -eq "Y") -or ($PromptOption -eq "Yes"))
        {
            return $True
        }
        elseif (($PromptOption -eq "N") -or ($PromptOption -eq "No"))
        {
            return $False
        }
        else
        {
            Write-Host "$RedSign" "Retype a valid option: " -NoNewLine
        }
    } while ($PromptOption -notin @("", "Y", "Yes", "N", "No"))
}

# ┌───────────┐
# │ Execution │
# └───────────┘

if (($Remove) -and ($Args.Count -eq 0))
{
    $Directories = Check-Directories
    $Paths = Check-Paths
    if ($Directories -and $Paths)
    {
        Write-Host "$GreenSign" "Installation found."
        Print-LocalVersions
        Write-Host ""
        Write-Host "Uninstall?"
        $PromptAnswer = Prompt-Continue
        if ($PromptAnswer -eq $True)
        {
            try
            {
                Write-Host ""
                Write-Host "Deleting directories..."
                Delete-Directories
                Write-Host "Removing paths..."
                Remove-Paths
                Write-Host "Refreshing paths in the current shell..."
                $Env:Path =
                    [System.Environment]::GetEnvironmentVariable("Path", [System.EnvironmentVariableTarget]::Machine) +
                    [System.Environment]::GetEnvironmentVariable("Path", [System.EnvironmentVariableTarget]::User)
                Write-Host "$GreenSign" "Done."
                Write-Host "$YellowSign" "Other apps may need to be restarted to stop using Git and Moar paths."
            }
            catch
            {
                Write-Host ""
                Write-Host "$RedSign" "Something went wrong."
            }
        }
        else
        {
            Write-Host ""
            Write-Host "$YellowSign" "Uninstall canceled."
        }
    }
    else
    {
       Write-Host "$RedSign" "Installation not found."
    }

}
elseif ($Args.Count -eq 0)
{
    $Directories = Check-Directories
    $Paths = Check-Paths
    if ($Directories -and $Paths)
    {
        Write-Host "Checking for updates..."
        $GitRepoVersion = Get-GitRepoVersion
        $MoarRepoVersion = Get-MoarRepoVersion
        switch ($True)
        {
            ((git --version) -ne "git version $GitRepoVersion") {Write-Host "$YellowSign" "Git update found ($GitRepoVersion)."; $GitUpdateAvailable = $True}
            ((moar --version) -ne "v$MoarRepoVersion") {Write-Host "$YellowSign" "Moar update found ($MoarRepoVersion)."; $MoarUpdateAvailable = $True}
            Default {Write-Host "$GreenSign" "Git and Moar are up to date."}
        }
        if ($GitUpdateAvailable -or $MoarUpdateAvailable)
        {
            Write-Host ""
            Write-Host "Update?"
            $PromptAnswer = Prompt-Continue
            if ($PromptAnswer -eq $True)
            {
                try
                {
                    Write-Host ""
                    Write-Host "Updating..."
                    if ($GitUpdateAvailable)
                    {
                        Write-Host "Downloading Git..."
                        Download-Git
                    }
                    if ($MoarUpdateAvailable)
                    {
                        Write-Host "Downloading Moar..."
                        Download-Moar
                    }
                    Write-Host "$GreenSign" "Done."
                    Print-LocalVersions
                }
                catch
                {
                    Write-Host ""
                    Write-Host "$RedSign" "Something went wrong."
                    Print-LocalVersions
                }
            }
            else
            {
                Write-Host ""
                Write-Host "$YellowSign" "Update not started."
                Print-LocalVersions
            }
        }
        else
        {
            Print-LocalVersions
        }
    }
    else
    {
        $GitRepoVersion = Get-GitRepoVersion
        $MoarRepoVersion = Get-MoarRepoVersion
        Write-Host "$YellowSign" "Git ($GitRepoVersion) and Moar ($MoarRepoVersion) will be installed."
        Write-Host ""
        Write-Host "Install?"
        $PromptAnswer = Prompt-Continue
        if ($PromptAnswer -eq $True)
        {
            try
            {
                Write-Host ""
                Write-Host "Downloading Git..."
                Download-Git
                Write-Host "Downloading Moar..."
                Download-Moar
                Write-Host "Adding paths..."
                Add-Paths
                Write-Host "Refreshing paths in the current shell..."
                $Env:Path =
                    [System.Environment]::GetEnvironmentVariable("Path", [System.EnvironmentVariableTarget]::Machine) +
                    [System.Environment]::GetEnvironmentVariable("Path", [System.EnvironmentVariableTarget]::User)
                Write-Host "$GreenSign" "Done."
                Write-Host "$YellowSign" "May need to restart other applications to start using Git and Moar."
                Print-LocalVersions
            }
            catch
            {
                Write-Host ""
                Write-Host "$RedSign" "Something went wrong."
            }
        }
        else
        {
            Write-Host ""
            Write-Host "$YellowSign" "Installation canceled."
        }
    }
}
else
{
    if ($Args.Count -eq 1)
    {
        Write-Host "$RedSign" "Parameter not valid."
    }
    else
    {
        Write-Host "$RedSign" "Parameters not valid."
    }
}
