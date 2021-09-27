#!/usr/bin/env zsh

function _zshef::util::lang::go::install::cmd() {
    echo "${ZSHEF_GO_INSTALL_CMD:-go install}"
}

function zshef::util::lang::go::install() {
    zshef::util::mng::is_installed "go" || {
        zshef::util::log::error "required golang"
        return 1
    }

    $(_zshef::util::lang::go::install::cmd) $@
}

function zshef::util::lang::go::update() {
    zshef::util::lang::go::install "$1"
}
