# ---- PROMPT ----
# Changes to a colored prompt, adds username and hostname, and trims the path of the working directory
function prompt
{
    $Private:UserAtComputer = "$([char]0x1b)[38;5;16;48;5;187m$env:UserName@$env:ComputerName $([char]0x1b)[0m"
    $Private:ShortPath = "$([char]0x1b)[38;5;16;48;5;150m $(Split-Path -Path (Get-Location) -Qualifier)\$([char]0x1b)[0m"
    $Private:MediumPath = "$([char]0x1b)[38;5;16;48;5;150m $(Split-Path -Path (Get-Location) -Qualifier)\$(Split-Path -Path (Get-Location) -Leaf) $([char]0x1b)[0m"
    $Private:LongPath = "$([char]0x1b)[38;5;16;48;5;150m $(Split-Path -Path (Get-Location) -Qualifier)\...\$(Split-Path -Path (Get-Location) -Leaf) $([char]0x1b)[0m"
    $Private:EndGreaterThan = "`n$([char]0x1b)[38;5;231;48;5;239m >$([char]0x1b)[0m"
    # user@computer drive:\ >
    if  (-not (Split-Path -Path (Get-Location) -Parent))
    {
        #"`n$([char]0x1b)[38;5;187;48;5;16m$([char]0xe0ba)$([char]0x1b)[0m" +
        "$UserAtComputer$ShortPath" +
        "$([char]0x1b)[38;5;150;48;5;16m$([char]0xe0cc)$([char]0x1b)[0m" +
        "$EndGreaterThan" +
        "$([char]0x1b)[38;5;239;48;5;16m$([char]0xe0b0)$([char]0x1b)[0m "
    }
    # user@computer drive:\working-directory >
    elseif ((Split-Path -Path (Get-Location) -Parent) -eq ((Split-Path -Path (Get-Location) -Qualifier) + "\"))
    {
        "$UserAtComputer$MediumPath$EndGreaterThan"
    }
    # user@computer drive:\...\working-directory >
    else
    {
        "$UserAtComputer$LongPath$EndGreaterThan"
    }
}

# ---- VARIABLES ----
# Contains the location of the user directories
$DOC = "$HOME\Documents"
$DWN = "$HOME\Downloads"
$PRJ = "$HOME\Documents\Projects"
$STD = "$HOME\Documents\Study"

# ---- FUNCTIONS ----
# Sets the current working location to the user directories
# Home
function SHOM {Set-Location $HOME}
# Documents
function SDOC {Set-Location $HOME\Documents}
# Downloads
function SDWN {Set-Location $HOME\Downloads}
# Projects: Creates the directory if it doesn't exist
function SPRJ
{
    if (Test-Path -Path $HOME\Documents\Projects)
    {
        Set-Location $HOME\Documents\Projects
    }
    else
    {
        New-Item $HOME\Documents\Projects -ItemType Directory
        Set-Location $HOME\Documents\Projects
    }
}
# Study: Creates the directory if it doesn't exist
function SSTD
{
    if (Test-Path -Path $HOME\Documents\Study)
    {
        Set-Location $HOME\Documents\Study
    }
    else
    {
        New-Item $HOME\Documents\Study -ItemType Directory
        Set-Location $HOME\Documents\Study
    }
}