# Base
alias bc="bc -l"
alias c="clear"
#alias cd="cd & ls"
alias ls="ls -A --color=auto"

# Editor
alias vi=nvim
alias vim=nvim
alias edit=nvim
alias vis='nvim "+set si"'

# Shortcuts
alias dfiles="cd ~/Projects/dotfiles"

# Information
alias myip="curl http://ipecho.net/plain; echo"
alias ports="netstat -tulanp"

# Utils
alias szsh='source ~/.zshrc'
alias connjabra="bluetoothctl connect 70:BF:92:D1:07:D3"
alias discjabra="bluetoothctl disconnect 70:BF:92:D1:07:D3"
alias cpic="feh --bg-fill --randomize ~/.config/wallpapers"
alias ppd='feh -g 640x480 -d -S filename'
alias what_i_got="pacman -Qqe | fzf"

alias ping="ping -c 5"

