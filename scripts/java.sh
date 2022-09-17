#!/usr/bin/env bash

set -euo pipefail
IFS=$'\n\t'

source scripts/const.sh

arch=$(dpkg --print-architecture)

# https://wiki.debian.org/Java
setup_java() {
  echo "Info: start setup_java()...."
  sudo apt install default-jdk
}

setup_java
