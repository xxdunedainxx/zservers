#! /bin/bash

set -u
set -e

APP_BIN_DIR=$(pwd)
source "${APP_BIN_DIR}/000.src"

Main() {
  kubeInit
  echo "yah?"
}

Main "${@:1}"