#!/usr/bin/env bash

set -euo pipefail
IFS=$'\n\t'

install_common_pkgs() {
  echo '--- install_common_pkgs() ---'
  sudo apt install \
    emacs \
    git \
    ripgrep \
    fd-find \
    shellcheck \
    zsh \
    autojump \
    curl \
    rsync \
    markdown
}

install_common_pkgs
