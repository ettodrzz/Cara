# Get the current location
$private:Path = "$((Get-Location).Path)"

# Prompt color
function private:Additive
{
	return "$(Get-Random -Minimum 200 -Maximum 250)"
}
$private:Color = "$([Char]0x1B)[38;2;0;0;0;48;2;$(Additive);$(Additive);$(Additive)m"
$private:ColorReset = "$([Char]0x1B)[0m"

# Change window title
$Host.UI.RawUI.WindowTitle = $Path

# Change prompt
return "$Color > $ColorReset "