#!/usr/bin/env zsh

function zshef::util::mng::is_installed() {
  : ${1:?should have 1 argument} || return 1
  type ${1} >/dev/null 2>&1
}

