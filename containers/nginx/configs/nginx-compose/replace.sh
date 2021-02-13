#! /bin/bash

echo "nginx-compose replacement!"

sed -i -e "s/{minio}/$MINIO_SERVER/g" /etc/nginx/nginx.conf
sed -i -e "s/{vault}/$VAULT_SERVER/g" /etc/nginx/nginx.conf
cat /etc/nginx/nginx.conf
