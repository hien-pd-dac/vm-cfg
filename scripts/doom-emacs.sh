#!/usr/bin/env bash

set -euo pipefail
IFS=$'\n\t'

install_doom_emacs() {
  echo '--- install_doom_emacs() ---'
  if [[ ! -d ~/.emacs.d/ ]]; then
    git clone --depth 1 https://github.com/doomemacs/doomemacs ~/.emacs.d
    ~/.emacs.d/bin/doom install
  fi
}

install_doom_emacs
