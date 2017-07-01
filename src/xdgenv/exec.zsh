#! /usr/bin/env zsh

SELF="${0##*/}"
. xdgenv-prelude

if (( ${argv[(I)--]} )) then
  if [[ $1 = "--" ]] ; then
    shift
  else
    prefix=${1?"Missing argument prefix"}
    dir=${2?"Missing argument dir"}
    [[ $3 = "--" ]] || fatal "unexpected third argument"
    shift 3
  fi
fi


export XDG_DATA_HOME=${XDG_DATA_HOME:-~/.local/share}
export XDG_CONFIG_HOME=${XDG_CONFIG_HOME:-~/.config}
export XDG_DATA_DIRS=${XDG_DATA_DIRS:-/usr/local/share:/usr/share}
export XDG_CONFIG_DIRS=${XDG_CONFIG_DIRS:-/etc/xdg}
export XDG_CACHE_HOME=${XDG_CACHE_HOME:-~/.cache}

[[ -n ${prefix:-} ]] && {
  v=${prefix}_DATA_HOME
  export $v=${(P)v:-${XDG_DATA_HOME}/$dir}

  v=${prefix}_CONFIG_HOME
  export $v=${(P)v:-${XDG_CONFIG_HOME}/$dir}

  v=${prefix}_CONFIG_DIRS
  export $v=${(P)v:-${XDG_CONFIG_DIRS//://$dir:}/$dir}

  v=${prefix}_CACHE_HOME
  export $v=${(P)v:-${XDG_CACHE_HOME}/$dir}

  v=${prefix}_DATA_DIRS
  export $v=${(P)v:-${XDG_DATA_DIRS//://$dir:}/$dir}
}

check-arg "command" ${1:-}
check-executable $1
exec "$@"
