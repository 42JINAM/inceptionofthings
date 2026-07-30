#!/usr/bin/env bash 
set -e

apt-get update
apt-get install -y apache2
systemctl enable --now apache2
