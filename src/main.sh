#!/usr/bin/env zsh

function zshef::help(){
cat <<-EOH
$0 <command>

<command>
    init    : TBD
    install : Run install function (no update)
    update  : Run update function (no install)
    run     : Run install/update function
EOH
}

for f in ${${(%):-%N}:A:h}/*/*.sh
do
  source $f
done
