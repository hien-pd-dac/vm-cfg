#!/usr/bin/env bash

set -euo pipefail
IFS=$'\n\t'

source scripts/const.sh

install_i3() {
  echo '--- install_i3() ---'
  sudo apt install i3 xorg
  
  sudo apt install fonts-powerline fonts-font-awesome
  sudo apt install i3blocks feh pavucontrol arandr rofi
  mkdir -p "$HOME"/.config/i3/
  ln -s -f "$VM_CFG_PATH"/files/i3/config "$HOME"/.config/i3/config

  # requirements
  # see also: https://bumblebee-status.readthedocs.io/en/main/modules.html
  git clone --depth 1 https://github.com/tobi-wan-kenobi/bumblebee-status.git "$HOME"/.config/i3/bumblebee-status/
  ## cpu
  sudo apt install python3-pip
  sudo apt install pipx
  pipx install psutil
  ## nic
  pipx install netifaces
  sudo apt install iw
  ##puseout
  # pipx install pulsectl
  sudo apt install pulseaudio pavucontrol
}

install_i3
