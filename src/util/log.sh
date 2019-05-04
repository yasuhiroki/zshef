#!/usr/bin/env zsh

function __zshef::util::log::prefix() {
  echo -n "\e[32m[$(date +%T)][ZSHEF]\e[m"
}

function zshef::util::log::echo() {
  echo "$(__zshef::util::log::prefix) $@"
}

function zshef::util::log::echos() {
  for v in ${@}
  do
    zshef::util::log::echo "$v"
  done
}

function zshef::util::log::header() {
  echo "$(__zshef::util::log::prefix) \e[34m$@\e[m"
}

function zshef::util::log::headers() {
  for v in ${@}
  do
    zshef::util::log::header "$v"
  done
}

function zshef::util::log::debug() {
  echo "$(__zshef::util::log::prefix)[DEBUG] $@"
}

function zshef::util::log::debugs() {
  for v in ${@}
  do
    zshef::util::log::debug "$v"
  done
}

function zshef::util::log::error() {
  echo "$(__zshef::util::log::prefix)\e[31m[ERROR] $@\e[m"
}

function zshef::util::log::errors() {
  for v in ${@}
  do
    zshef::util::log::error "$v"
  done
}
