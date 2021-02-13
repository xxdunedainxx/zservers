# Environment variables
# This expects:
# DISCORD_API_KEY
source ~/.zservers

home=$(pwd)

# Build docker images

# VAULT

cd ./containers/vault

docker build . --build-arg \
       SECRET_JSON_STR="{\"discord\":
       [{\"key\":\"token\",
       \"value\":\"${DISCORD_API_KEY}\"
       }]}" \
       -t vault

# Generate vault root token

# Run docker compose
