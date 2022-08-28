#!/usr/bin/env bash

set -euo pipefail
IFS=$'\n\t'

install_golang() {
  echo "--- install_golang() ---"

  if [[ ! -d /usr/local/go/ ]]; then
    ( goversion=go1.16.15 && \
      curl -fLo ~/$goversion.linux-amd64.tar.gz --create-dirs https://golang.org/dl/$goversion.linux-amd64.tar.gz && \
      sudo tar -C /usr/local/ -xzf ~/$goversion.linux-amd64.tar.gz && \
      rm ~/$goversion.linux-amd64.tar.gz )
  fi

  /usr/local/go/bin/go install golang.org/x/tools/gopls@latest
  /usr/local/go/bin/go install golang.org/x/tools/cmd/goimports@latest
  /usr/local/go/bin/go install golang.org/x/lint/golint@latest
  /usr/local/go/bin/go install github.com/golang/mock/mockgen@v1.6.0

  if [[ ! -f $HOME/go/bin/golangci-lint ]]; then
    curl -sSfL https://raw.githubusercontent.com/golangci/golangci-lint/master/install.sh | sh -s -- -b $(/usr/local/go/bin/go env GOPATH)/bin v1.46.2
  fi
}

install_golang
