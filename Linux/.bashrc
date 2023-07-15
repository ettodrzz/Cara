# Bash history
# ------------
# Number of lines in active history
HISTSIZE=512
# Number of lines in Bash history
HISTFILESIZE=1024
# Ignore duplicate commands
HISTCONTROL=ignoredups
# Append history
shopt -s histappend

# Check the window size after each command, if necessary,
# update the values of LINES and COLUMNS
shopt -s checkwinsize

# Prompt
# ------
# Trims the path of the working directory
PROMPT_DIRTRIM=1
# Change to a colored prompt
# Colors (foreground_background):
# - black_lime   "\[\e[38;5;16;48;5;150m\]"
# - black_yellow "\[\e[38;5;16;48;5;187m\]"
# - black_orange "\[\e[38;5;16;48;5;216m\]"
# - white_gray   "\[\e[38;5;231;48;5;239m\]"
# - reset color  "\[\e[0m\]"
# ---- ---- ---- ----
# user@host
PS1="\n\[\e[38;5;16;48;5;150m\] \u@\h \[\e[0m\]"
# working-directory
PS1+="\[\e[38;5;16;48;5;187m\] \w \[\e[0m\]"
# $
PS1+="\n\[\e[38;5;231;48;5;239m\] $ \[\e[0m\] "

# Enable color support of ls and also add handy aliases
if [ -x /usr/bin/dircolors ]; then
    test -r ~/.dircolors && eval "$(dircolors -b ~/.dircolors)" || eval "$(dircolors -b)"
    alias ls='ls --color=auto'
    alias dir='dir --color=auto'
    alias vdir='vdir --color=auto'
    alias grep='grep --color=auto'
    alias fgrep='fgrep --color=auto'
    alias egrep='egrep --color=auto'
fi

# Functions
# ---------
# Change the current working directory to a specific Folder
function cdoc() { cd ~/Documents; }
function cdwn() { cd ~/Downloads; }
# Create the directories if it doesn't exist
function cprj()
{
    if [ -d ~/Documents/Projects ]
    then
        cd ~/Documents/Projects
    else
        mkdir ~/Documents/Projects
        echo Projects directory created
        cd ~/Documents/Projects
    fi
}
function cstd()
{
    if [ -d ~/Documents/Study ]
    then
        cd ~/Documents/Study
    else
        mkdir ~/Documents/Study
        echo Study directory created
        cd ~/Documents/Study
    fi
}

# Source NVM
#export NVM_DIR="$HOME/.nvm"
#[ -s "$NVM_DIR/nvm.sh" ] && \. "$NVM_DIR/nvm.sh"  # This loads nvm
#[ -s "$NVM_DIR/bash_completion" ] && \. "$NVM_DIR/bash_completion"  # This loads nvm bash_completion
