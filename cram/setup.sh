#!/usr/bin/env zsh

export TESTTMP="$CRAMTMP/$TESTFILE"

FAKEPATH="$TESTTMP/path"
mkdir "${FAKEPATH}" || return
export PATH="${FAKEPATH}:${PATH}"
