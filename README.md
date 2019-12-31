# Zshef

# Description

Zshef is a tool for management your dotfiles, install scripts and others.  
Briefly, Zshef is alike Chef.  But Zshef does not need ruby.

# Installation

## CLI

```sh
$ curl https://raw.githubusercontent.com/yasuhiroki/zshef/master/install.sh | sh
```

## Zplug

```sh
zplug "yasuhiroki/zshef", use:init.sh
```

## Manual

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

```sh
$ zshef config [files...]
```

## Zshef file

zshef runs \*.zshef files in `cookbooks` directory.

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
# Write config script
function zshef::config() {

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
    zshef::util::os::mac::install "git"
  }
}

function zshef::update() {
  :
}

function zshef::update::osx() {
  zshef::util::mng::is_installed "git" && {
    zshef::util::os::mac::update "git"
  }
}

function zshef::config() {
  git config --global push.default simple
}
```

### Example Usage

```sh
$ ls
cookbooks

$ ls ./cookbooks
git.zshef

$ zshef run
[10:27:21][ZSHEF] install start
[10:27:21][ZSHEF] Run ./cookbooks/git.zshef
[10:27:21][ZSHEF] install end
[10:27:21][ZSHEF] update start
[10:27:21][ZSHEF] Run ./cookbooks/git.zshef
git is already updated
[10:27:23][ZSHEF] update end
[10:27:23][ZSHEF] config start
[10:27:23][ZSHEF] Run ./cookbooks/git.zshef
[10:27:23][ZSHEF] config end
```

# Development

## Test

`zsh test.sh`

# Author

@yasuhiroki

# License

[MIT](./LICENSE)
