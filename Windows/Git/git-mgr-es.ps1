<#
.SYNOPSIS
Administrador de Git para Windows (v0.6)
.DESCRIPTION
Descarga, actualiza o desinstala Git.
MinGit es una version simple de Git, sin funciones extras como Git-Bash and Git-Gui.
Tambien incluye Moar, un paginador muy bueno.
Ambos programas son instalados para el usuario actual.
.PARAMETER Eliminar
Desinstala Git y Moar.
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
    [Alias("E")]
    [Switch]$Eliminar
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
    reg add HKCU\Environment /v Path /t REG_EXPAND_SZ /d $UpdatedPathEnvVar /f | Out-Null
}
# ┌─  Removes Git and Moar paths in the current user's Path environment variable.
Function Remove-Paths
{
    $IndexPathEnvVar = ((reg query HKCU\Environment /v Path)[2]).LastIndexOf("    ") + 4
    $PathEnvVar = ((reg query HKCU\Environment /v Path)[2]).Substring($IndexPathEnvVar)
    $UpdatedPathEnvVar = (($PathEnvVar).Replace("%LocalAppData%\Programs\Git\mingw64\bin;", "")).Replace("%LocalAppData%\Programs\Moar;", "")
    reg add HKCU\Environment /v Path /t REG_EXPAND_SZ /d $UpdatedPathEnvVar /f | Out-Null
}

# ┌ Versions ┐
# └──────────┘
# ┌─ Prints the names of the installed versions of Git and Moar.
Function Print-LocalVersions
{
    Write-Host ""
    Write-Host "Versiones instaladas:"
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
    Write-Host "[S]S$([char]0xED) " -ForegroundColor Yellow -NoNewLine
    Write-Host "[N]No: " -NoNewLine
    do
    {
        $PromptOption = Read-Host
        if (($PromptOption -eq "") -or ($PromptOption -eq "S") -or ($PromptOption -eq "Si") -or ($PromptOption -eq "S$([char]0xED)"))
        {
            return $True
        }
        elseif (($PromptOption -eq "N") -or ($PromptOption -eq "No"))
        {
            return $False
        }
        else
        {
            Write-Host "$RedSign" "Vuelva a escribir una opci$([char]0xF3)n valida: " -NoNewLine
        }
    } while ($PromptOption -notin @("", "S", "Si", "S$([char]0xED)", "N", "No"))
}

# ┌───────────┐
# │ Execution │
# └───────────┘

if (($Eliminar) -and ($Args.Count -eq 0))
{
    $Directories = Check-Directories
    $Paths = Check-Paths
    if ($Directories -and $Paths)
    {
        Write-Host "$GreenSign" "Instalaci$([char]0xF3)n encontrada."
        Print-LocalVersions
        Write-Host ""
        Write-Host "$([char]0xBF)Desinstalar?"
        $PromptAnswer = Prompt-Continue
        if ($PromptAnswer -eq $True)
        {
            try
            {
                Write-Host ""
                Write-Host "Borrando carpetas..."
                Delete-Directories
                Write-Host "Quitando rutas..."
                Remove-Paths
                Write-Host "Actualizando las rutas en el shell actual..."
                $Env:Path =
                    [System.Environment]::GetEnvironmentVariable("Path", [System.EnvironmentVariableTarget]::Machine) +
                    [System.Environment]::GetEnvironmentVariable("Path", [System.EnvironmentVariableTarget]::User)
                Write-Host "$GreenSign" "Hecho."
                Write-Host "$YellowSign" "Quiz$([char]0xE1) otras aplicaciones necesiten ser reiniciadas para que dejen de usar la rutas de Git y Moar."
            }
            catch
            {
                Write-Host ""
                Write-Host "$RedSign" "Algo sali$([char]0xF3) mal. Visite https://github.com/ettodrzz/Cara/blob/main/Windows/Git/git.md para ver c$([char]0xF3)mo desinstalar manualmente."
            }
        }
        else
        {
            Write-Host ""
            Write-Host "$YellowSign" "Desinstalaci$([char]0xF3)n cancelada."
        }
    }
    else
    {
       Write-Host "$RedSign" "Instalaci$([char]0xF3)n no encontrada."
    }

}
elseif ($Args.Count -eq 0)
{
    $Directories = Check-Directories
    $Paths = Check-Paths
    if ($Directories -and $Paths)
    {
        Write-Host "Revisando si hay actualizaciones disponibles..."
        $GitRepoVersion = Get-GitRepoVersion
        $MoarRepoVersion = Get-MoarRepoVersion
        switch ($True)
        {
            ((git --version) -ne "git version $GitRepoVersion") {Write-Host "$YellowSign" "Actualizaci$([char]0xF3)n de Git disponible ($GitRepoVersion)."; $GitUpdateAvailable = $True}
            ((moar --version) -ne "v$MoarRepoVersion") {Write-Host "$YellowSign" "Actualizaci$([char]0xF3)n de Moar disponible ($MoarRepoVersion)."; $MoarUpdateAvailable = $True}
            Default {Write-Host "$GreenSign" "Las $([char]0xFA)ltimas versiones Git y Moar ya est$([char]0xE1)n instaladas."}
        }
        if ($GitUpdateAvailable -or $MoarUpdateAvailable)
        {
            Write-Host ""
            Write-Host "$([char]0xBF)Actualizar?"
            $PromptAnswer = Prompt-Continue
            if ($PromptAnswer -eq $True)
            {
                try
                {
                    Write-Host ""
                    Write-Host "Actualizando..."
                    if ($GitUpdateAvailable)
                    {
                        Write-Host "Descargando Git..."
                        Download-Git
                    }
                    if ($MoarUpdateAvailable)
                    {
                        Write-Host "Descargando Moar..."
                        Download-Moar
                    }
                    Write-Host "$GreenSign" "Hecho."
                    Print-LocalVersions
                }
                catch
                {
                    Write-Host ""
                    Write-Host "$RedSign" "Algo sali$([char]0xF3) mal. Visite https://github.com/ettodrzz/Cara/blob/main/Windows/Git/git.md para ver c$([char]0xF3)mo actualizar manualmente."
                    Print-LocalVersions
                }
            }
            else
            {
                Write-Host ""
                Write-Host "$YellowSign" "Actualizaci$([char]0xF3)n interrumpida."
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
        Write-Host "$YellowSign" "Git ($GitRepoVersion) y Moar ($MoarRepoVersion) ser$([char]0xE1)n instalados."
        Write-Host ""
        Write-Host "$([char]0xBF)Instalar?"
        $PromptAnswer = Prompt-Continue
        if ($PromptAnswer -eq $True)
        {
            try
            {
                Write-Host ""
                Write-Host "Descargando Git..."
                Download-Git
                Write-Host "Descargando Moar..."
                Download-Moar
                Write-Host "Agregando rutas..."
                Add-Paths
                Write-Host "Actualizando las rutas en el shell actual..."
                $Env:Path =
                    [System.Environment]::GetEnvironmentVariable("Path", [System.EnvironmentVariableTarget]::Machine) +
                    [System.Environment]::GetEnvironmentVariable("Path", [System.EnvironmentVariableTarget]::User)
                Write-Host "$GreenSign" "Hecho."
                Write-Host "$YellowSign" "Quiz$([char]0xE1) necesite reiniciar otras aplicaciones para empezar a usar Git y Moar."
                Print-LocalVersions
            }
            catch
            {
                Write-Host ""
                Write-Host "$RedSign" "Algo sali$([char]0xF3) mal. Visite https://github.com/ettodrzz/Cara/blob/main/Windows/Git/git.md para ver c$([char]0xF3)mo instalar manualmente."
            }
        }
        else
        {
            Write-Host ""
            Write-Host "$YellowSign" "Instalaci$([char]0xF3)n cancelada."
        }
    }
}
else
{
    if ($Args.Count -eq 1)
    {
        Write-Host "$RedSign" "Par$([char]0xE1)metro no valido."
    }
    else
    {
        Write-Host "$RedSign" "Par$([char]0xE1)metro no valido."
    }
}
