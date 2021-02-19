#! /bin/sh

export TRUSTED_TOKEN=${TRUSTED_TOKEN:='replaceme'}
export VAULT_TOKEN_JSON=${VAULT_TOKEN_JSON:='\{\}'}
export SERVICE_DISCOVERY=${SERVICE_DISCOVERY:=''}
export SECRET_JSON_STR=${SECRET_JSON_STR:='\{\}'}
export VAULT_ADDR=${VAULT_ADDR:=http://0.0.0.0:8200}
export VAULT_DEV_LISTEN_ADDRESS=${VAULT_ADDR:=0.0.0.0:8200}

nohup vault server -dev -dev-listen-address=$VAULT_ADDR -dev-root-token-id=$TRUSTED_TOKEN -config vault-server.hcl >/dev/stdout 2>&1 &

sleep 10
export VAULT_ADDR="http://${VAULT_ADDR}"

# Generate Secrets
vault secrets enable kv-v2
vault secrets enable -path=secrets kv

./dispatcher/run.sh $TRUSTED_TOKEN token.json $VAULT_ADDR $SECRET_JSON_STR