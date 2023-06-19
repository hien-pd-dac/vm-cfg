#!/usr/bin/env bash

set -euo pipefail
IFS=$'\n\t'

install_common_pkgs() {
  echo '--- install_common_pkgs() ---'
  sudo apt update && sudo apt install \
    aptitude \
    emacs \
    vim \
    htop \
    neofetch \
    git \
    pipx \
    ripgrep \
    fd-find \
    shellcheck \
    zsh \
    autojump \
    curl \
    rsync \
    jsonnet \
    spice-webdavd \
    flameshot \
    cmake \
    ibus-unikey \
    markdown
}

install_common_pkgs
