#!/usr/bin/env bash

set -euo pipefail
IFS=$'\n\t'

source scripts/const.sh

__setup_neovim() {
  if [[ -f /usr/bin/nvim ]]; then
    echo "Info: neovim aldready be installed. Skipped."
    exit 0
  fi
  echo "Info: start setup_neovim()..."
  __install_neovim
  __install_vimPlug
  __clone_nvim_cfg
  __resolve_dependencies
}

__install_neovim() {
  echo "Info: start install_neovim()..."
  # current using Debian bullseye with neovim apt
  sudo apt install neovim
  # git clone --depth 1 https://github.com/neovim/neovim.git ~/.neovim/
  # (
    # cd ~/.neovim/
    # rm -rf build/  # clear the CMake cache
    # make CMAKE_EXTRA_FLAGS="-DCMAKE_INSTALL_PREFIX=$HOME/.neovim"
    # make install
    # ln -s -f $HOME/.neovim/bin/nvim $MY_APP_PATH/bin/
    # export PATH="$HOME/neovim/bin:$PATH"
  # )
}

__install_vimPlug() {
  echo "Info: start install_vimPlug()..."
  if [[ ! -f  "${XDG_DATA_HOME:-$HOME/.local/share}"/nvim/site/autoload/plug.vim ]]; then
    sh -c 'curl -fLo "${XDG_DATA_HOME:-$HOME/.local/share}"/nvim/site/autoload/plug.vim --create-dirs \
          https://raw.githubusercontent.com/junegunn/vim-plug/master/plug.vim'
  fi
}

__clone_nvim_cfg() {
  echo "Info: start clone_nvim_cfg()..."
  mkdir -p ~/.config/nvim/
  ln -s -f "$VM_CFG_PATH/files/nvim/coc-settings.json" ~/.config/nvim/
  ln -s -f "$VM_CFG_PATH/files/nvim/init.vim" ~/.config/nvim/
}

__resolve_dependencies() {
  echo "Info: start resolve_dependencies()..."
  __install_nvim_pkg_python3
#TODO: need to install python2 nvim pkgs?
  __install_ripgrep
  __install_need_pkgs
  install_Ctags_libs
}

__install_nvim_pkg_python3() {
  echo "Info: start install_nvim_pkg_python3()..."
  sudo apt install python3-neovim
}

__install_need_pkgs() {
  echo "Info: start install_nodejs()..."
  # curl -sL https://deb.nodesource.com/setup_14.x | sudo -E bash -
  sudo apt install nodejs
  sudo apt install npm
  echo "Info: start install neovim pkg on nodejs..."
  sudo npm install -g neovim
  echo "Info: start install jsontlint, fixjson..."
  sudo npm install -g fixjson
  sudo npm install -g jsonlint
  sudo npm install -g bash-language-server
  # for js formatter
  sudo npm install -g prettier
  # for js linter
  sudo npm install -g eslint
  echo "Info: start install tflint for terraform..."
  curl https://raw.githubusercontent.com/terraform-linters/tflint/master/install_linux.sh | bash
}

# Ctags installation
# https://github.com/preservim/tagbar
install_Ctags_libs() {
  sudo apt install exuberant-ctags
}

__install_ripgrep() {
  echo "Info: start install_ripgrep()..."
  sudo apt install ripgrep
}

__setup_neovim
