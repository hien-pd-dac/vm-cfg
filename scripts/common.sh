#!/usr/bin/env bash

set -euo pipefail
IFS=$'\n\t'

install_common_pkgs() {
  echo '--- install_common_pkgs() ---'
  sudo apt update && sudo apt install \
    aptitude \
    emacs \
    htop \
    neofetch \
    git \
    ripgrep \
    fd-find \
    shellcheck \
    zsh \
    autojump \
    curl \
    rsync \
    jsonnet \
    spice-webdavd \
    markdown
}

install_common_pkgs
