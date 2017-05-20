# Zshef

# Description

Zshef is a tool for management your dotfiles, install scripts and others.  
Briefly, Zshef is alike Chef.  But Zshef does not need ruby.

# Installation

```sh
$ export ZSHEF_HOME=/path/to/.zshef
$ git clone https://github.com/yasuhiroki/zshef $ZSHEF_HOME
$ source $ZSHEF_HOME/init.sh
```

## Required

- zsh: version 5.0

# Feature

- Management your dotfiles.
- Management your bin file.
- Management your install/update script.

# Usage

## CLI

```sh
# TBD
$ zshef init
```

```sh
$ zshef run
```

```sh
$ zshef install [files...]
```

```sh
$ zshef update [files...]
```

## Zshef file

Zshef runs \*.zshef files in working directory.

```sh
# Write install script
function zshef::install() {

}
```

```sh
# Write update script
function zshef::update() {

}
```

```sh
# Write install script fo mac
function zshef::install::osx() {

}
```

### Example

sample for git install/update zshef file

```sh
#!/usr/bin/env zsh

function zshef::install() {
    :
}

function zshef::install::osx() {
    zshef::util::mng::is_installed "git" || {
        brew install git
    }

function zshef::update() {
    :
}

function zshef::update::osx() {
    zshef::util::mng::is_installed "git" && {
        brew upgrade git
    }
}
```

### Example Usage

```sh
$ ls
cookbooks

$ ls ./cookbooks
git.zshef

$ zshef install
[11:21:50][ZSHEF] install start
[11:21:50][ZSHEF][DEBUG] working directory /Users/yasuhiroki/zshef-sample/
[11:21:50][ZSHEF][DEBUG] ./cookbooks/git.zshef
[11:21:50][ZSHEF] Run ./cookbooks/git.zshef zshef::install
[11:21:50][ZSHEF] Run ./cookbooks/git.zshef zshef::install::osx
[11:21:50][ZSHEF] install end
```

# Development

## Test

`zsh test.sh`

# Author

@yasuhiroki

# License

[MIT](./LICENSE.md)
