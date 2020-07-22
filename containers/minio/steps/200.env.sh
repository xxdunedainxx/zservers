#! /bin/bash

echo "export MINIO_ACCESS_KEY=${MINIO_ACCESS_KEY}" >> env.sh
echo "export MINIO_SECRET_KEY=${MINIO_SECRET_KEY}" >> env.sh
echo "export MINIO_DRIVE_MOUNT=${MINIO_DRIVE_MOUNT}" >> env.sh
echo "export MINIO_SYM_LINK=${MINIO_SYM_LINK}" >> env.sh
echo "export MINIO_PORT=${MINIO_PORT}" >> env.sh