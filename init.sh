#!/usr/bin/env zsh

typeset -g ZSHEF_ROOT_DIR=${${(%):-%N}:A:h}

source $ZSHEF_ROOT_DIR/src/main.sh

[[ $PATH =~ "$ZSHEF_ROOT_DIR/bin" ]] || {
  export PATH=$ZSHEF_ROOT_DIR/bin:$PATH
}
