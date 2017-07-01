#!/bin/false
# vim: filetype=sh

function fatal {
  printf >&2 -- "%s: fatal: %s\n" $SELF "$@"
  exit 1
}

function check_executable {
  type "$1" >/dev/null 2>&1 || fatal "cannot execute $1"
}

function check_arg {
  test -z "${2:-}" && fatal "missing argument $1"
}

function cmd_dispatch {
  check_arg "command" ${1:-}

  local cmd=$SELF-$1
  shift

  check_executable $cmd
  exec $cmd "$@"
}
