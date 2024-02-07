custom_prompt()
{
	# Generate random RGB color
	additive()
	{
		echo "$(shuf --input-range 200-250 --head-count 1)"
	}
	local color="$(additive);$(additive);$(additive)"

	# Prompt colors
	local color_bg="\[\e[38;2;0;0;0;48;2;${color}m\]"
	local color_fg="\[\e[38;2;${color};49m\]"
	local color_reset="\[\e[0m\]"

	# Nerd Fonts
	# Name                 | Logo | Code
	# ---------------------|------|-----
	# pl-left_hard_divider |     | e0b0
	local div="$(echo -e "\Ue0b0")"

	# Change window title
	PS1="\[\033]2;\w\007\]"

	# Change prompt
	PS1+="$color_bg \$ $color_fg$div$color_reset "

	unset additive
}

custom_prompt
unset custom_prompt
