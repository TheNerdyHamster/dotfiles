export STARSHIP_CONFIG=~/.config/starship/starship.toml

GPG_TTY=`tty`
export GPG_TTY

export LANG=en_US.UTF-8

# Preferred editor for local and remote sessions
if [[ -n $SSH_CONNECTION ]]; then
  export EDITOR='vim'
else
  export EDITOR='mvim'
fi

# Golang
export PATH="$PATH:$HOME/go/bin"
