#! /bin/sh 

export TRUSTED_TOKEN=$1
export VAULT_TOKEN_JSON=$(cat $2)
export VAULT_ADDR=$3

python3 dispatcher/app.py