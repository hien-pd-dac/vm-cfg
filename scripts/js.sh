#!/usr/bin/env bash

set -euo pipefail
IFS=$'\n\t'

install_js() {
  echo "--- install_js() ---"

  if [[ ! -f /usr/bin/nodejs ]]; then
    curl -fsSL https://deb.nodesource.com/setup_16.x | sudo -E bash -
    sudo apt-get install -y nodejs
  fi
}

install_js
