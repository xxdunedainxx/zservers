#! /bin/bash

# Download minio 
wget https://dl.min.io/server/minio/release/linux-amd64/minio

# Alow execution
chmod +x minio

# Move to bin for easy execution 
mv minio /usr/local/bin
