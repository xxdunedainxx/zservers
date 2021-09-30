#! /bin/bash

# Download minio 
wget "https://dl.min.io/server/minio/release/${ARCHITECTURE}/minio"

# download mc client
wget "https://dl.min.io/client/mc/release/${ARCHITECTURE}/mc"

# Alow execution
chmod +x minio
chmod +x mc

# Move to bin for easy execution 
mv minio /usr/local/bin
mv mc /usr/local/bin

mkdir -p "${MINIO_SYM_LINK}"

# Sym link them together
ln -s "${MINIO_DRIVE_MOUNT}" "${MINIO_SYM_LINK}"
