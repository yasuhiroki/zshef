#!/usr/bin/env zsh

function zshef::core::interface::command() {
  local cmd="$1"

  case "$cmd" in
    init)
      echo "No implemented yet"
      return 1
      ;;
    run)
      zshef::core::interface::install $(pwd)
      zshef::core::interface::update $(pwd)
      ;;
    install)
      zshef::core::interface::install $(pwd)
      ;;
    update)
      zshef::core::interface::update $(pwd)
      ;;
    *)
      echo "No support command"
      return 1
      ;;
  esac
}

function zshef::core::interface::install() {
  __zshef::core::interface::runner "$1" "install"
}

function zshef::core::interface::update() {
  __zshef::core::interface::runner "$1" "update"
}

function __zshef::core::interface::runner() {
  local work_dir="$1"
  [ -d "${work_dir}" ] || return 1

  local cmd="$2"

  zshef::util::log::header "${cmd} start"
  (
    cd ${work_dir}
    zshef::util::log::debug "working directory ${work_dir}"

    [ -d ./cookbooks ] || return 1
    zshef::util::log::debugs $(ls ./cookbooks/*.zshef)

    for f in ./cookbooks/*.zshef
    do
      (
        zshef::util::log::header "Run ${f} zshef::${cmd}"
        # TODO: Delete previous functions
        source $f
        zshef::${cmd}
        [ $? != 0 ] && {
          zshef::util::log::error "Error ${f} zshef::${cmd}"
          return 1
        }
        if zshef::util::os::is_osx; then
          zshef::util::log::header "Run ${f} zshef::${cmd}::osx"
          zshef::${cmd}::osx
          [ $? != 0 ] && {
            zshef::util::log::error "Error ${f} zshef::${cmd}::osx"
            return 1
          }
        elif zshef::util::os::is_debian; then
          zshef::util::log::header "Run ${f} zshef::${cmd}::debian"
          zshef::${cmd}::debian
          [ $? != 0 ] && {
            zshef::util::log::error "Error ${f} zshef::${cmd}::debian"
            return 1
          }
        fi
        return 0
      )
      [ $? != 0 ] && {
        zshef::util::log::error "Error ${f} zshef::${cmd}"
        return 1
      }
    done
  )
  local rtn=$?
  zshef::util::log::header "${cmd} end"
  return ${rtn}
}
