export ZSH="/home/thenerdyhamster/.oh-my-zsh"

# Set name of the theme to load --- if set to "random", it will
# load a random theme each time oh-my-zsh is loaded, in which case,
# to know which specific one was loaded, run: echo $RANDOM_THEME
# See https://github.com/ohmyzsh/ohmyzsh/wiki/Themes
ZSH_THEME="robbyrussell"

HYPHEN_INSENSITIVE="true"

DISABLE_UNTRACKED_FILES_DIRTY="true"

plugins=(git fast-syntax-highlighting ssh-agent sudo)

# Source 
source $ZSH/oh-my-zsh.sh

source ~/.zsh/.aliases.zsh
source ~/.zsh/.completion.zsh
source ~/.zsh/.exports.zsh

# Star ship
eval "$(starship init zsh)"
