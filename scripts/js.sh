#!/usr/bin/env bash

set -euo pipefail
IFS=$'\n\t'

install_js() {

  if [[ -f /usr/bin/nodejs ]]; then
    echo "Info: nodejs already be installed. Skipped."
    exit 0
  fi

  echo "--- install_js() ---"
  curl -fsSL https://deb.nodesource.com/setup_16.x | sudo -E bash -
  sudo apt-get update
  sudo apt-get install -y nodejs
}

install_js
