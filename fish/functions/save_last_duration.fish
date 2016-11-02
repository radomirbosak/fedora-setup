function save_last_duration --on-event fish_postexec
  set -g last_duration $CMD_DURATION
end