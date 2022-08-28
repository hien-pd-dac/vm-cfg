#!/usr/bin/env bash

set -euo pipefail
IFS=$'\n\t'

source const.sh

install_oh_my_zsh() {
  echo "--- install_oh-my-zsh() ---"
  if [[ ! -d ~/.oh-my-zsh/ ]]; then
    (sh -c "$(curl -fsSL https://raw.github.com/ohmyzsh/ohmyzsh/master/tools/install.sh)")
  fi

  if [[ ! -d ~/.oh-my-zsh/custom/plugins/zsh-autosuggestions/ ]]; then
    git clone https://github.com/zsh-users/zsh-autosuggestions.git "$HOME/.oh-my-zsh/custom/plugins/zsh-autosuggestions"
  fi

  if [[ ! -d ~/.oh-my-zsh/custom/plugins/zsh-syntax-highlighting/ ]]; then
    git clone https://github.com/zsh-users/zsh-syntax-highlighting.git "$HOME/.oh-my-zsh/custom/plugins/zsh-syntax-highlighting"
  fi

  echo "install p10k zsh ---"
  if [[ ! -d ~/.oh-my-zsh/custom/themes/powerlevel10k/ ]]; then
    git clone --depth=1 https://github.com/romkatv/powerlevel10k.git ${ZSH_CUSTOM:-$HOME/.oh-my-zsh/custom}/themes/powerlevel10k
  fi
  ln -s -f "$VM_CFG_PATH/files/zshrc" ~/.zshrc
}

install_oh_my_zsh
