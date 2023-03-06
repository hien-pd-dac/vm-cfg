#!/usr/bin/env bash

set -euo pipefail
IFS=$'\n\t'

arch=$(dpkg --print-architecture)
# https://docs.aws.amazon.com/cli/latest/userguide/getting-started-install.html
setup_aws() {
  echo "Info: start setup_aws()...."
  local myarch
  if [[ $arch == "arm64" ]]; then
    myarch="aarch64"
  elif [[ $arch == "amd64" ]]; then
    myarch="x86_64"
  else
    echo "Unkown architecture: $arch"
    exit 1
  fi
  curl -fLo /tmp/awscliv2.zip --create-dirs "https://awscli.amazonaws.com/awscli-exe-linux-$myarch.zip" && \
    sudo unzip /tmp/awscliv2.zip && \
    sudo /tmp/aws/install && \
    rm -rf /tmp/aws

}

setup_aws
