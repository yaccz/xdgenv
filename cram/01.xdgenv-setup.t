check the variables we'll look for are not already set
======================================================

  $ env | grep XDG
  [1]
  $ env | grep FOO
  [1]

setup XDG variables
===================

  $ xdgenv exec env | grep XDG
  XDG_DATA_HOME=/home/*/.local/share (glob)
  XDG_CONFIG_HOME=/home/*/.config (glob)
  XDG_DATA_DIRS=/usr/local/share:/usr/share
  XDG_CONFIG_DIRS=/etc/xdg
  XDG_CACHE_HOME=/home/*/.cache (glob)

setup application variables
===========================

  $ . xdgenv-exec FOO foo -- env | grep FOO
  FOO_DATA_HOME=/home/yac/.local/share/foo
  FOO_CONFIG_HOME=/home/yac/.config/foo
  FOO_CONFIG_DIRS=/etc/xdg/foo
  FOO_CACHE_HOME=/home/yac/.cache/foo
  FOO_DATA_DIRS=/usr/local/share/foo:/usr/share/foo

parent environment takes precedence
===================================

  $ export XDG_CONFIG_HOME=/t1
  $ export FOO_CONFIG_HOME=/t2

  $ xdgenv-exec FOO foo -- env | grep -P '(XDG|FOO)_CONFIG_HOME'
  XDG_CONFIG_HOME=/t1
  FOO_CONFIG_HOME=/t2

missing command
===============

  $ xdgenv-exec
  xdgenv-exec: fatal: missing argument command
  [1]

invalid command
===============

  $ xdgenv-exec blergh
  xdgenv-exec: fatal: cannot execute blergh
  [1]
