#!/usr/bin/env bash

# Utility functions that helpers for dotfiles will utilies and not the dotfiles themselves.
echo_with_prompt() {
  PROMPT="${PROMPT:-'TNH dotfiles'}"
  echo "$PROMPT $@"
}
execute_func_with_prompt() {

  # Args
  # $1 - the function to call
  # $2 - the thing this function does
  # Returns 1 if the user cancels the operation
  # Returns 2 if the function failed
  # Returns 0 if all went well

	echo_with_prompt "This utility will $2"
	echo_with_prompt "Proceed? (y/n)"
	read resp
	# TODO - regex here?
	if [ "$resp" = 'y' -o "$resp" = 'Y' ] ; then
    # This thing here "calls" the function
    "$1" || return 2
		echo_with_prompt "$2 complete"
	else
		echo_with_prompt "$2 cancelled by user"
    return 1
	fi
}

function get_os() {
  local os=''
  if [ $( echo "$OSTYPE" | grep 'linux-gnu' ) ] ; then
    # This file contains all the details you need!
    source /etc/os-release
    os="${ID_LIKE:-$ID}"
  else
    os='unknown'
  fi

  export DETECTED_OS="$os"

  echo "$os"
}
