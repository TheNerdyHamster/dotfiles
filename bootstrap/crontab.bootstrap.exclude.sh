
#!/bin/bash

# Bootstrapper for cron tab
. "$( pwd )/utils.exclude.sh"

PROMPT='[ CronTab Bootstrapper ]'

crons=(
  # Once every month update system packages
  '0 0 1 * * yay -Syyu'
)

echo_crons() {
  # The ${myarray{@} syntax expands to all the elements in the array
  for cron in "${crons[@]}" ; do
    echo "$cron"
  done
}

add_to_crontab() {
  (crontab -l 2>/dev/null ; echo_crons) | crontab -
}

add_to_crontab

echo_with_prompt "Updated the crontab!"
