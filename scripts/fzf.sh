#!/usr/bin/env bash

set -euo pipefail
IFS=$'\n\t'

source scripts/const.sh

install_fzf() {
  echo "Info: start install_fzf()...."
  if [[ -d ~/.fzf ]]; then
    echo "Info: fzf aldready be installed. Skipped."
    exit 0
  fi
  echo "Info: start setup_fzf()..."
  # install using git for later version
  git clone --depth 1 https://github.com/junegunn/fzf.git ~/.fzf
  ~/.fzf/install
}

install_fzf
