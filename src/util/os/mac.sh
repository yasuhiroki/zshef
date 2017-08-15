#!/usr/bin/env zsh

function _zshef::util::os::mac::install::cmd() {
  echo "${ZSHEF_MAC_INSTALL_CMD:-brew}"
}

function zshef::util::os::mac::install() {
  $(_zshef::util::os::mac::install::cmd) install $1
}

function zshef::util::os::mac::update() {
  if $(_zshef::util::os::mac::install::cmd) outdated | grep -sq "^$1"; then
    $(_zshef::util::os::mac::install::cmd) upgrade $1
  else
    echo "$1 is already updated"
  fi
}

