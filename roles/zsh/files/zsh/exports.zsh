GPG_TTY=`tty`
export GPG_TTY

export LANG=en_US.UTF-8

# Preferred editor for local and remote sessions
if [[ -n $SSH_CONNECTION ]]; then
  export EDITOR='vim'
else
  export EDITOR='nvim'
fi

# Golang
export PATH="$PATH:$HOME/go/bin"

# Less & man pages
# Start blinking
export LESS_TERMCAP_mb=$(tput bold; tput setaf 4) # Blue
# Start bold
export LESS_TERMCAP_md=$(tput bold; tput setaf 4) # Blue
# Start standout
export LESS_TERMCAP_so=$(tput bold; tput rev; tput setaf 6) # Cyan
# End standout
export LESS_TERMCAP_se=$(tput rmso; tput sgr0)
# Start underline
export LESS_TERMCAP_us=$(tput smul; tput bold; tput setaf 5) # Magenta
# End bold, blinking, standout, underline
export LESS_TERMCAP_me=$(tput sgr0)
