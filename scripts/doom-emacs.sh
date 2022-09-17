#!/usr/bin/env bash

set -euo pipefail
IFS=$'\n\t'

install_doom_emacs() {
  echo '--- install_doom_emacs() ---'
  if [[ ! -f /usr/bin/emacs ]]; then
    echo "Info: emacs already be installed. Skipped."
    sudo apt install emacs
  fi
  if [[ ! -f ~/.emacs.d/bin/doom ]]; then
    echo "Info: start installing doom-emacs."
    rm -rf ~/.emacs.d/
    git clone --depth 1 https://github.com/doomemacs/doomemacs ~/.emacs.d
    ~/.emacs.d/bin/doom install
    doom sync -u
  fi

}

install_doom_emacs
