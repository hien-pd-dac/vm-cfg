#!/usr/bin/env bash

set -euo pipefail
IFS=$'\n\t'

install_ccls() {
  echo "--- install_ccls() ---"
  sudo apt install \
    ccls \
    gdb
}

# install unit testing library
install_catch2() {
  mkdir -p ~/.tmp/
  (cd ~/.tmp && \
   git clone https://github.com/catchorg/Catch2.git
   cd Catch2
   cmake -Bbuild -H. -DBUILD_TESTING=OFF
   sudo cmake --build build/ --target install
  )
  rm -rf ~/.tmp/
}

main() {
	install_ccls
	install_catch2
}

main
