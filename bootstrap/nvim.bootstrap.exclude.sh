#!/usr/bin/env bash

# Bootstrap for Neovim.

. "$(pwd)/utils.exclude.sh"

PROMPT='[ NeoVim Bootstrapper ]'

echo_with_prompt "Installing vim-plug for NeoVim"
sh -c 'curl -fLo "${XDG_DATA_HOME:-$HOME/.local/share}"/nvim/site/autoload/plug.vim --create-dirs \
       https://raw.githubusercontent.com/junegunn/vim-plug/master/plug.vim'

echo_with_prompt "Completed!"
