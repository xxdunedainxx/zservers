# Environment variables
# This expects:
# DISCORD_API_KEY
source ~/.zservers
# https://stackoverflow.com/questions/13322485/how-to-get-the-primary-ip-address-of-the-local-machine-on-linux-and-os-x
ip=$(ipconfig getifaddr en0)
home=$(pwd)

# Build docker images

# Minio
cd ./containers/minio
docker build . --build-arg MINIO_PORT=8888 --build-arg ARCHITECTURE=linux-amd64 -t minio
cd $home
# VAULT

cd ./containers/vault

docker build . --build-arg \
       SECRET_JSON_STR="{\"discord\":
       [{\"key\":\"token\",
       \"value\":\"${DISCORD_API_KEY}\"
       }]}" \
       -t vault

cd $home

cd ./containers/nginx
docker build . --build-arg NGINX_CONF_OVERRIDE=./configs/nginx-compose --build-arg VAULT_SERVER=${ip}:8200 --build-arg MINIO_SERVER=${ip}:8080 -t ingress

# Generate vault root token

# Run docker compose
cd $home

cd ./containers

docker-compose up