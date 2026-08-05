#!/bin/bash
# get the master node's IP from the arguments.
MASTER_IP=$1

# get token
TOKEN=$(cat /vagrant/token)

curl -sfL https://get.k3s.io | K3S_URL=https://$MASTER_IP:6443 K3S_TOKEN=$TOKEN sh -
