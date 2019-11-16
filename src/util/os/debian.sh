#!/usr/bin/env zsh

function _zshef::util::os::debian::install::cmd() {
  echo "${ZSHEF_MAC_INSTALL_CMD:-apt}"
}

function zshef::util::os::debian::install() {
  $(_zshef::util::os::debian::install::cmd) install $1
}

function zshef::util::os::debian::update() {
  $(_zshef::util::os::debian::install::cmd) upgrade $1
}

