#! /bin/sh

echo '######## RUNNING ZK SUB PROCESS ########'

export TRUSTED_TOKEN=$1
#export VAULT_TOKEN_JSON=$(cat $2)
export VAULT_ADDR=$3
export SECRET_JSON_STR=$4

echo 'RUNNING dispatcher/app.py'
python3 dispatcher/app.py
