#!/usr/bin/env zsh

function zshef::util::os::is_osx() {
  [[ $(uname) =~ "Darwin" ]]
}

function zshef::util::os::is_linux() {
  [[ $(uname) =~ "Linux" ]]
}

function zshef::util::os::is_debian() {
  zshef::util::os::is_linux && [[ -e "/etc/debian_version" || -e "/etc/lsb-release" ]]
}

function zshef::util::os::install() {
  if zshef::util::os::is_osx; then
    $(zshef::util::os::mac::install) $1
  elif zshef::util::os::is_debian; then
    $(zshef::util::os::debian::install) $1
  else
    zshef::util::log::error 'Not supported'
  fi
}

function zshef::util::os::update() {
  if zshef::util::os::is_osx; then
    $(zshef::util::os::mac::update) $1
  elif zshef::util::os::is_debian; then
    $(zshef::util::os::debian::update) $1
  else
    zshef::util::log::error 'Not supported'
  fi
}
