#! /bin/bash

echo "nginx-compose replacement!"

sed -i "s/{minio}/$MINIO_SERVER/g" /etc/nginx/nginx.conf

cat /etc/nginx/nginx.conf