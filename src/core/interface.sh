#!/usr/bin/env zsh

function zshef::core::interface::command() {
  local cmd="$1"
  shift

  case "$cmd" in
    init)
      zshef::core::interface::init $(pwd) "${@}"
      ;;
    run)
      zshef::core::interface::install $(pwd) "${@}"
      zshef::core::interface::update $(pwd) "${@}"
      zshef::core::interface::config $(pwd) "${@}"
      ;;
    install)
      zshef::core::interface::install $(pwd) "${@}"
      ;;
    config)
      zshef::core::interface::config $(pwd) "${@}"
      ;;
    update)
      zshef::core::interface::update $(pwd) "${@}"
      ;;
    *)
      echo "No support command"
      return 1
      ;;
  esac
}

function zshef::core::interface::init() {
  local work_dir="$1"
  [ -d "${work_dir}" ] || return 1
  (
    cd ${work_dir}
    zshef::util::log::echo "Create directory"
    mkdir -p cookbooks
    zshef::util::log::echo "Create sample zshef file"
cat <<EOH > cookbooks/sample.zshef
function zshef::install() {
  echo "Install something"
}

function zshef::update() {
  echo "Update something"
}
EOH
    )
}

function zshef::core::interface::install() {
  __zshef::core::interface::runner "install" $@
}

function zshef::core::interface::update() {
  __zshef::core::interface::runner "update" $@
}

function zshef::core::interface::config() {
  __zshef::core::interface::runner "config" $@
}

function __zshef::core::interface::runner() {
  local cmd="$1"
  local work_dir="$2"
  [ -d "${work_dir}" ] || return 1
  shift 2

  zshef::util::log::header "${cmd} start"
  (
    cd ${work_dir}
    zshef::util::log::debug "working directory ${work_dir}"

    [ -d ./cookbooks ] || return 1
    zshef::util::log::debugs $(ls ./cookbooks/*.zshef)

    test -n "${1}" && zshef::util::log::debug "Specify cookbooks by ${@}"
    for f in $(__zshef::core::interface::selector ${@})
    do
      __zshef::core::interface::run::cookbook "${cmd}" "${f}" || {
        zshef::util::log::error "Error ${f} zshef::${cmd}"
        return 1
      }
      for f2 in $(__zshef::core::interface::selector::subdir $(basename -s '.zshef' "${f}"))
      do
        __zshef::core::interface::run::cookbook "${cmd}" "${f2}" || {
          zshef::util::log::error "Error ${f2} zshef::${cmd}"
          return 1
        }
      done
    done
  )
  local rtn=$?
  zshef::util::log::header "${cmd} end"
  return ${rtn}
}

function __zshef::core::interface::selector() {
  test -z "${1}" && {
    echo ./cookbooks/*.zshef
    return 0
  }

  local rtn=()
  : # Need any command ???
  for f in ./cookbooks/*.zshef
  do
    for l in ${@}
    do
      [[ ${f} =~ ${l}.zshef ]] && rtn+=(${f})
    done
  done
  echo ${rtn[@]}
  return 0
}

function __zshef::core::interface::selector::subdir() {
  local base="$1"
  test -d ./cookbooks/${base} || {
    return 0
  }
  echo ./cookbooks/${base}/*.zshef
  return 0
}

function __zshef::core::interface::run::cookbook() {
  local cmd="$1"
  local f="$2"
  (
    zshef::util::mng::unset "${cmd}"
    source "$f"
    zshef::util::log::header "Run ${f}"
    __zshef::core::interface::run::function "zshef::${cmd}::before"
    __zshef::core::interface::run::function "zshef::${cmd}"

    if zshef::util::os::is_osx; then
      __zshef::core::interface::run::function "zshef::${cmd}::osx::before"
      __zshef::core::interface::run::function "zshef::${cmd}::osx"
      __zshef::core::interface::run::function "zshef::${cmd}::osx::after"
    elif zshef::util::os::is_debian; then
      __zshef::core::interface::run::function "zshef::${cmd}::debian::before"
      __zshef::core::interface::run::function "zshef::${cmd}::debian"
      __zshef::core::interface::run::function "zshef::${cmd}::debian::after"
    fi
    __zshef::core::interface::run::function "zshef::${cmd}::after"
    return 0
  )
}

function __zshef::core::interface::run::function() {
  local fn=${1}
  if zshef::util::mng::is_defined ${fn}; then
    zshef::util::log::debug "${fn}"
    ${fn}
    [ $? != 0 ] && {
      zshef::util::log::error "Error ${fn}"
      return 1
    }
  else
    zshef::util::log::debug "Skip ${fn}"
  fi
}
