#! /bin/sh

echo "executing VAULT setup!"
home=$(pwd) 

for script in steps/*;
  do
    echo "RUNNING $script"

    # windows carriage return issue 
    sed -i 's/\r//g' ./$script

    # allow execute
    chmod 777 ./$script

    sh ./$script
    echo "FINISH RUNNING $script"

    # always reset to home dir
    cd $home
done