# Environment variables
# This expects:
# DISCORD_API_KEY
source ~/.zservers
# https://stackoverflow.com/questions/13322485/how-to-get-the-primary-ip-address-of-the-local-machine-on-linux-and-os-x
ip=$(ipconfig getifaddr en0)
home=$(pwd)


echo $DISCORD_API_KEY

build_container_service() {
  # $1 == service to build 
  # $2 == docker command
  cd $home
  cd "./containers/${1}"
  docker kill $1 || true
  docker rm $1 || true
  eval $2
  cd $home
}

docker_compose_start() {
  echo "test"
}

# Generate vault root token

# Build docker images

# Minio
#build_container_service "minio" "docker build . --build-arg MINIO_PORT=8888 --build-arg ARCHITECTURE=linux-arm -t minio"


# VAULT
SECRETS_STR="
{\"discord\":
  [
    {
      \"key\":\"token\",
      \"value\":\"${DISCORD_API_KEY}\"
    }
  ]
}
"

echo $SECRETS_STR

build_container_service "vault" "
   docker build . --build-arg
      SECRET_JSON_STR=\"${SECRETS_STR}\" --no-cache -t zvault"

#build_container_service "nginx" " \
#docker build . --build-arg NGINX_CONF_OVERRIDE=./configs/nginx-compose \
#--build-arg VAULT_SERVER=${ip}:8200 --build-arg MINIO_SERVER=${ip}:8080 -t ingress \
#"

#build_container_service "elasticsearch" "docker build . -t es"

#build_container_service "kibana" "docker build . -t kib"

#build_container_service "servicediscovery" "docker build . -t servicediscovery"
#
#build_container_service "servicediscovery-ui" "docker build . -t servicediscovery-ui"

cd ./containers

docker-compose up
