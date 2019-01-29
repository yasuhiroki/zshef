#!/usr/bin/env zsh

source ${${(%):-%N}:A:h}/../init.sh

zshef::util::os::is_osx   || echo 'Failed, should be return 0'
zshef::util::os::is_linux && echo 'Failed, should be return 1'
