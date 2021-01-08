#!/usr/bin/env bash
set -e

tags="$1"

if [ -z $tags ]; then
  tags="all"
fi

if ! [ -x "$(command -v ansible)" ]; then
  sudo pacman -S ansible
fi

ansible-galaxy install kewlfft.aur 

ansible-playbook -i hosts dotfiles.yml --ask-become-pass --tags $tags

if command -v terminal-notifier 1>/dev/null 2>&1; then
  terminal-notifier -title "TNH-dotfiles: Bootstrap complete" -message "Successfully setup TNH enviorment."
fi

echo "doe"
