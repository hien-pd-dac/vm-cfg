#!/usr/bin/env bash

set -euo pipefail
IFS=$'\n\t'

install_ccls() {
  echo "--- install_ccls() ---"
  sudo apt install \
    ccls \
    gdb
}

install_ccls
