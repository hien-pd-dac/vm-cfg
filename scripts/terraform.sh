#!/usr/bin/env bash

set -euo pipefail
IFS=$'\n\t'

source scripts/const.sh

arch=$(dpkg --print-architecture)

setup_terraform() {
  echo "Info: start setup_terraform()...."

  # if [[ -f /usr/bin/terraform ]]; then
    # echo "Info: terraform already be installed. Skipped."
    # return
  # fi

  # sudo apt update && sudo apt install -y gnupg software-properties-common curl

  # wget -O- https://apt.releases.hashicorp.com/gpg | \
    # gpg --dearmor | \
    # sudo tee /usr/share/keyrings/hashicorp-archive-keyring.gpg

  # gpg --no-default-keyring \
    # --keyring /usr/share/keyrings/hashicorp-archive-keyring.gpg \
    # --fingerprint

  # echo "deb [signed-by=/usr/share/keyrings/hashicorp-archive-keyring.gpg] \
    # https://apt.releases.hashicorp.com $(lsb_release -cs) main" | \
    # sudo tee /etc/apt/sources.list.d/hashicorp.list

  # sudo apt update && sudo apt install terraform

  # The code above did not work.
  # So work around with binary file:
  # https://www.terraform.io/downloads

  if [[ -f $LOCAL_APP_PATH/bin/terraform ]]; then
    echo "Info: terraform already be installed. Skipped."
    exit 0
  fi
  curl -fLo /tmp/terraform.zip --create-dirs https://releases.hashicorp.com/terraform/1.2.9/terraform_1.2.9_linux_$arch.zip && \
    sudo unzip /tmp/terraform.zip -d $LOCAL_APP_PATH/bin/
  rm -rf /tmp/terraform.zip
}

setup_terraform
