#!/usr/bin/env zsh

function zshef::help(){
cat <<-EOH
zshef <command>

<command>
    init    : Create directories for zshef
    install : Run install function
    update  : Run update function
    config  : Run config function
    run     : Run install, update and config function
EOH
}

for f in ${${(%):-%N}:A:h}/*/**/*.sh
do
  source $f
done
