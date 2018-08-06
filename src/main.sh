#!/usr/bin/env zsh

function zshef::help(){
cat <<-EOH
$0 <command>

<command>
    init    : Create directories for zshef
    install : Run install function (no run update)
    update  : Run update function (no run install)
    run     : Run install and update function
EOH
}

for f in ${${(%):-%N}:A:h}/*/**/*.sh
do
  source $f
done
