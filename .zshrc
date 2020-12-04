if [[ -r "${XDG_CACHE_HOME:-$HOME/.cache}/p10k-instant-prompt-${(%):-%n}.zsh" ]]; then
  source "${XDG_CACHE_HOME:-$HOME/.cache}/p10k-instant-prompt-${(%):-%n}.zsh"
fi
export ZSH="/home/lilahamstern/.oh-my-zsh"

ZSH_THEME="powerlevel10k/powerlevel10k"

plugins=(git ssh-agent)

source $ZSH/oh-my-zsh.sh

alias e='emacsclient --alternate-editor="" --no-wait $*'

zstyle :omz:plugins:ssh-agent identities id_ed25519 git_rsa
#source ~/_mullvad
export PKG_CONFIG_PATH=/opt/local/lib/pkgconfig
# To customize prompt, run `p10k configure` or edit ~/.p10k.zsh.
[[ ! -f ~/.p10k.zsh ]] || source ~/.p10k.zsh

export PATH="$PATH:$HOME/go/bin"

export KUBECONFIG=:/home/lilahamstern/.kube/config:/home/lilahamstern/.kube/configs/kubeconfig.yaml
export KUBE_EDITOR='emacsclient --alternate-editor="" --no-wait $*'

# Autocompletion for dotnet-cli
_dotnet_zsh_complete()
{
  local completions=("$(dotnet complete "$words")")

  reply=( "${(ps:\n:)completions}" )
}

compctl -K _dotnet_zsh_complete dotnet

source /usr/share/fzf/completion.zsh
source /usr/share/fzf/key-bindings.zsh
