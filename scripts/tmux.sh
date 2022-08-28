#!/usr/bin/env bash

set -euo pipefail
IFS=$'\n\t'

source const.sh

install_tmux() {
  echo "--- install_tmux() ---"
  sudo apt install tmux
  if [[ ! -d ~/.tmux/plugins/tpm/ ]]; then
    git clone https://github.com/tmux-plugins/tpm ~/.tmux/plugins/tpm
  fi
  ln -s -f "$VM_CFG_PATH/files/tmux.conf" ~/
}

install_tmux
