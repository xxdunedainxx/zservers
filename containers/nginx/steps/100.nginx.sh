#!/bin/bash

echo "nginx setup.."

if [[ ! -z "${NGINX_CONF_OVERRIDE}" && "${NGINX_CONF_OVERRIDE}" != "N/A" ]] ; then
  echo "nginx conf override!"
  rm /etc/nginx/nginx.conf 
  mv "${NGINX_CONF_OVERRIDE}/nginx.conf" /etc/nginx/nginx.conf

  bash "./${NGINX_CONF_OVERRIDE}/replace.sh"
fi