# Window title, prompt
function Prompt {
	. $Home\Scripts\PS5_prompt.ps1
}

# Functions
# Change location to a specific directory
function SHOM {Set-Location $HOME}
function SDOC {Set-Location $HOME\Documents}
function SDWN {Set-Location $HOME\Downloads}
function SPRJ
{
	# If the directory doesn't exist, then creates it
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