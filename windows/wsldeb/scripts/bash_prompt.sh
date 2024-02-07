custom_prompt()
{
	# Prompt color
	additive()
	{
		echo "$(shuf --input-range 200-250 --head-count 1)"
	}
	local color="\[\e[38;2;0;0;0;48;2;$(additive);$(additive);$(additive)m\]"
	local color_reset="\[\e[0m\]"

	# Change window title
	PS1="\[\033]2;\w\007\]"

	# Change prompt
	PS1+="$color \$ $color_reset "

	unset additive
}

custom_prompt
unset custom_prompt
