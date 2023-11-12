#!/usr/bin/env bash

set -euo pipefail
IFS=$'\n\t'

install_golang() {
  echo "--- install_golang() ---"
  if [[ ! -d /usr/local/go/ ]]; then
    ( goversion=go1.20.1 arch=$(dpkg --print-architecture) && \
      curl -fLo ~/$goversion.linux-$arch.tar.gz --create-dirs https://golang.org/dl/$goversion.linux-$arch.tar.gz && \
      sudo tar -C /usr/local/ -xzf ~/$goversion.linux-$arch.tar.gz && \
      rm ~/$goversion.linux-$arch.tar.gz )
  fi

  /usr/local/go/bin/go install golang.org/x/tools/gopls@latest
  /usr/local/go/bin/go install golang.org/x/tools/cmd/goimports@latest
  /usr/local/go/bin/go install golang.org/x/lint/golint@latest
  /usr/local/go/bin/go install github.com/golang/mock/mockgen@v1.6.0
  /usr/local/go/bin/go install github.com/go-delve/delve/cmd/dlv@latest

  if [[ ! -f $HOME/go/bin/golangci-lint ]]; then
    curl -sSfL https://raw.githubusercontent.com/golangci/golangci-lint/master/install.sh | sh -s -- -b $(/usr/local/go/bin/go env GOPATH)/bin v1.46.2
  fi
}

install_golang
