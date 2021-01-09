
# append completions to fpath
fpath=(${ASDF_DIR}/completions $fpath)

# initialise completions with ZSH's compinit
autoload -Uz compinit

compinit -d ~/.cache/zsh/zcompdump-$ZSH_VERSION

autoload edit-command-line; zle -N edit-command-line
bindkey '^e' edit-command-line
# Autocompletion for dotnet-cli
#_dotnet_zsh_complete()
#{
#  local completions=("$(dotnet complete "$words")")

#  reply=( "${(ps:\n:)completions}" )
#}

#compctl -K _dotnet_zsh_complete dotnet
