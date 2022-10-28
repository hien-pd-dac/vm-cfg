#!/usr/bin/env bash

set -euo pipefail
IFS=$'\n\t'

source scripts/const.sh

arch=$(dpkg --print-architecture)

setup_jmeter() {
  JMETER_VERSION=5.4.2
  echo "Info: start setup_jmeter()...."

  # if [[ -f $LOCAL_APP_PATH/bin/jmeter ]]; then
    # echo "Info: jmeter already be installed. Skipped."
    # exit 0
  # fi

  if [[ ! -d $LOCAL_APP_PATH/apache-jmeter-$JMETER_VERSION ]]; then
    curl -fLo /tmp/dependencies/apache-jmeter-${JMETER_VERSION}.tgz --create-dirs https://archive.apache.org/dist/jmeter/binaries/apache-jmeter-${JMETER_VERSION}.tgz && \
      tar -xzf /tmp/dependencies/apache-jmeter-${JMETER_VERSION}.tgz -C $LOCAL_APP_PATH/ && \
      rm -rf /tmp/dependencies
  fi
  ln -s -f $LOCAL_APP_PATH/apache-jmeter-${JMETER_VERSION}/bin/jmeter $LOCAL_APP_PATH/bin/jmeter-$JMETER_VERSION
}

setup_jmeter
