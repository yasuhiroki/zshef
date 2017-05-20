#!/usr/bin/env zsh

function zshef::util::mng::is_installed() {
  : ${1:?should have 1 argument} || return 1
  type ${1} >/dev/null 2>&1
}

function zshef::util::mng::is_defined() {
  : ${1:?should have 1 argument} || return 1
  type ${1} >/dev/null 2>&1
}

function zshef::util::mng::unset() {
  local cmd="${1}"
  for fn in zshef::${cmd}{,::osx,::debian}
  do
    zshef::util::mng::is_defined ${fn} && unset -f ${fn}
  done
}
