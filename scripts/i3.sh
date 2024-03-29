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
  ln -s -f "$VM_CFG_PATH"/files/i3/gnome-background.svg \
     "$HOME"/.config/i3/gnome-background.svg
  

  # requirements
  # see also: https://bumblebee-status.readthedocs.io/en/main/modules.html
  if [[ ! -d "$HOME"/.config/i3/bumblebee-status ]]; then
    git clone --depth 1 https://github.com/tobi-wan-kenobi/bumblebee-status.git \
      "$HOME"/.config/i3/bumblebee-status/
  fi
  ## cpu
  sudo apt install python3-pip
  sudo apt install python3-psutil
  ## nic
  sudo apt install python3-netifaces
  sudo apt install iw
  ##puseout
  sudo apt install python3-pulsectl
  sudo apt install pulseaudio pavucontrol
}

install_i3
