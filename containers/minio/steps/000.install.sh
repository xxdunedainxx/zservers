#! /bin/bash

apt-get update --assume-yes
apt-get upgrade --assume-yes

apt-get install wget --assume-yes

# Needed for WD Passport backend
sudo apt-get install exfat-fuse exfat-utils --assume-yes
