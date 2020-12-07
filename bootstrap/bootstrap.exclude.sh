#!/bin/bash

. "$( pwd )/utils.exclude.sh"

PROMPT='[ Bootstraper ]'

source .exports

# Initialize a few things
init () {
  echo_with_prompt "Making a Projects folder in $PATH_TO_PROJECTS if it doesn't already exist"
	mkdir -p "$PATH_TO_PROJECTS"
	echo_with_prompt "Making a Playground folder in $PATH_TO_PLAYGROUND if it doesn't already exist"
	mkdir -p "$PATH_TO_PLAYGROUND"
}

# TODO : Delete symlinks to deleted files
# TODO - add support for -f and --force
link () {
  for file in $(ls .. -A | grep -vE '\.exclude*|\.git$|\.gitignore|\.gitmodules|.*.md') ; do
    # Silently ignore errors here because the files may already exist
    ln -sv "$PWD/$file" "$HOME" || true
  done
}

# TODO rewrite this to check for os=unknown, use the execute_func_with_prompt wrapper, etc
install_tools () {
  local os=$(get_os)
	if [ "$os" = 'arch' ] ; then
    echo_with_prompt "Detected OS $os"
		echo_with_prompt "This utility will install useful utilities using yay"
    echo_with_prompt "IMPORTANT! This script is only tested on archlinux."
		echo_with_prompt "Proceed? (y/n)"
		read resp
		# TODO - regex here?
		if [ "$resp" = 'y' -o "$resp" = 'Y' ] ; then
			echo_with_prompt "Installing useful stuff using yay. This may take a while..."
			sh yay.exclude.sh
		else
			echo_with_prompt "yay installation cancelled by user"
		fi
	else
		echo_with_prompt "Skipping installations using yay because Archlinux/Linux was not detected..."
	fi
}

bootstrap_vim() {
  # TODO consider sourcing this file
  "$( pwd )/vim.bootstrap.exclude.sh"
}

bootstrap_crontab() {
  # TODO consider sourcing this file
  "$( pwd )/crontab.bootstrap.exclude.sh"
}

init
execute_func_with_prompt link "symlink everything"
install_tools
execute_func_with_prompt bootstrap_vim "bootstrap vim with plugins and the like"
execute_func_with_prompt bootstrap_crontab "bootstrap the crontab"

# Exit script with a success, even if user exists during installation.
true
