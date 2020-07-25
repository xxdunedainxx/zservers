#! /bin/bash

echo "executing NGINX setup!"

apt-get update --assume-yes
apt-get upgrade --assume-yes

home=$(pwd)

chmod -R 755 $home

echo $home

for script in steps/*;
  do
    echo "RUNNING $script"

    # windows carriage return issue 
    sed -i 's/\r//g' ./$script

    # allow execute
    chmod 777 ./$script

    ./$script
    echo "FINISH RUNNING $script"

    # always reset to home dir
    cd $home
done