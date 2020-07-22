#! /bin/bash

# Download minio 
wget https://dl.min.io/server/minio/release/linux-${ARCHITECTURE}/minio

# Alow execution
chmod +x minio

# Move to bin for easy execution 
mv minio /usr/local/bin
