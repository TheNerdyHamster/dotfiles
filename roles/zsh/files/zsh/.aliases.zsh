# Base
alias bc="bc -l"
alias c="clear"
alias cd="cd & ls"
alias ls="ls -A --color=auto"

# Editor
alias vi=nvim
alias vim=nvim
alias edit=nvim
alias vis='nvim "+set si"'



# Information
alias myip="curl http://ipecho.net/plain; echo"
alias ports="netstat -tulanp"

# Utils
alias connjabra="bluetoothctl connect 70:BF:92:D1:07:D3"
alias discjabra="bluetoothctl disconnect 70:BF:92:D1:07:D3"
alias what_i_got="pacman -Qqe | fzf"

alias ping="ping -c 5"
