#!/usr/bin/env bash

set -euo pipefail
IFS=$'\n\t'

source scripts/const.sh

arch=$(dpkg --print-architecture)

setup_gcloud() {
  echo "Info: start setup_gcloud()...."
  __install_gcloud
  __install_need_gcloud_pkgs
}

__install_gcloud() {
  if [[ -f $LOCAL_APP_PATH/bin/gcloud ]]; then
    echo "Info: gcloud already be installed. Skipped"
    return
  fi
  arch_gcloud=""
  if [[ $arch == "amd64" ]]; then
    arch_gcloud="x86_64"
  elif [[ $arch == "arm64" ]]; then
    arch_gcloud="arm"
  fi
  ver=402.0.0
  curl -fLo /tmp/google-cloud-sdk-$ver-linux-$arch_gcloud.tar.gz --create-dirs https://dl.google.com/dl/cloudsdk/channels/rapid/downloads/google-cloud-sdk-$ver-linux-$arch_gcloud.tar.gz
  mkdir -p $LOCAL_APP_PATH
  tar -xzf /tmp/google-cloud-sdk-$ver-linux-$arch_gcloud.tar.gz -C $LOCAL_APP_PATH/
  $LOCAL_APP_PATH/google-cloud-sdk/install.sh
  mkdir -p $LOCAL_APP_PATH/bin/
  ln -s -f $LOCAL_APP_PATH/google-cloud-sdk/bin/gcloud $LOCAL_APP_PATH/bin/
  $LOCAL_APP_PATH/google-cloud-sdk/bin/gcloud init
  rm -rf /tmp/google-cloud*
}

__install_need_gcloud_pkgs() {
  echo "Info: start install_need_gcloud_pkgs()...."
  install_kubectl
  install_kustomize
  printf '\ngcloud components update\n'
  $LOCAL_APP_PATH/google-cloud-sdk/bin/gcloud components update
}

install_kubectl() {
  if [[ -f $LOCAL_APP_PATH/bin/kubectl ]]; then
    echo "Info: kubectl already be installed. Skipped"
    return
  fi
  echo "Info: start installing kubectl..."
  curl -fLo $LOCAL_APP_PATH/kubectl "https://dl.k8s.io/release/$(curl -L -s https://dl.k8s.io/release/stable.txt)/bin/linux/$arch/kubectl"
  chmod +x $LOCAL_APP_PATH/kubectl
  ln -s -f $LOCAL_APP_PATH/kubectl $LOCAL_APP_PATH/bin/
}

install_kustomize() {
  if [[ -f $HOME/go/bin/kustomize ]]; then
    echo "Info: kustomize already be installed. Skipped"
    return
  fi
  echo "Info: start installing kustomize..."
  go install sigs.k8s.io/kustomize/kustomize/v4@latest
}

setup_gcloud
