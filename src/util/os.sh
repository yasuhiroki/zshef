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

