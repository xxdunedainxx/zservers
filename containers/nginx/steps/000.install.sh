#! /bin/bash

echo "begin install scripts"

apt-get update --assume-yes

libs=("nginx" "vim" "net-tools" "curl")

for lib in "${libs[@]}"
  do
    echo "installing $lib"
    apt-get install $lib --assume-yes true
  done