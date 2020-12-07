#!/bin/bash

# Setup crontabs

. "$( pwd )/utils.exclude.sh"

PROMPT='[CrontabSetup]'

cron=(
    "0 12 * * MON yay -Syyu"
)

echo_crons() {
  for cron in "${crons[@]}"; do
    echo "$cron"
  done
}

add_cron() {
  (crobtab -l 2>/dev/null ; echo_crons) | crontab -
}

add_cron

echo_with_prompt "Updated crontab"
