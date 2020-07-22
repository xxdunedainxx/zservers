#! /bin/bash

source ~/.profile

apt-get install wget --assume-yes

# Download minio 
wget "https://dl.min.io/server/minio/release/linux-${LINUX_ARCHITECTURE}/minio"

# Alow execution
chmod +x minio

# Move to bin for easy execution 
mv minio /usr/local/bin

echo "export MINIO_ACCESS_KEY=${MINIO_ACCESS_KEY}" >> minio_env.sh
echo "export MINIO_SECRET_KEY=${MINIO_SECRET_KEY}" >> minio_env.sh