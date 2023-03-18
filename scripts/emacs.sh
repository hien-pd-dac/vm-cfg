#!/usr/bin/env bash

set -euo pipefail
IFS=$'\n\t'

source scripts/const.sh

install_emacs() {
  echo '--- install_emacs() ---'
  if [[ ! -f /usr/bin/emacs ]]; then
    echo "Info: emacs already be installed. Skipped."
    sudo apt install emacs
  fi
  ln -s -f "$VM_CFG_PATH"/files/emacs/init.el "$HOME"/.emacs.d/init.el

}

install_emacs
