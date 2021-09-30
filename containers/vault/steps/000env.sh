#! /bin/bash

# https://learn.hashicorp.com/tutorials/vault/configure-vault
# https://www.vaultproject.io/docs/configuration

# Set Env vars 
echo "Setting env vars.."
echo "export DISPATCHER_AUTH_TOKEN=${DISPATCHER_AUTH_TOKEN}" >> env.sh
echo "export VAULT_ADDR='http://127.0.0.1:8200'" >> env.sh
# Stupid vault docker bug: https://github.com/hashicorp/docker-vault/issues/2#issuecomment-241204619
echo "export VAULT_DEV_LISTEN_ADDRESS=0.0.0.0:8200" >> env.sh
echo "export VAULT_FORMAT=json" >> env.sh

echo "Generating HCL policies"

cat > vault-server.hcl <<EOF
disable_mlock = true
ui            = true

#listener "tcp" {
#  address     = "localhost:8200"
#  tls_disable = "true"
#}

storage "file" {
  path = "/tmp/vault-data"
}

path "web" {                                                                                                                                                 
    capabilities = ["list"]                                                                                                                                  
}     

path "web/*" {
    capabilities = ["create", "update", "delete", "list", "read"]
}

path "secret/*" {
  capabilities = ["read"]
}

EOF
