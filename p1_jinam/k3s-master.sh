#!/bin/bash

curl -sfL https://get.k3s.io | sh -
#install k3s binary 
#create systemd unit file at /etc/systemd/system/k3s.service
# systemctl enable k3s, enable the k3s service to start automatically at boot.
# systemctl restart k3s service

KUBE_USER="vagrant"
KUBE_HOME="/home/$KUBE_USER"

sudo mkdir -p $KUBE_HOME/.kube
sudo cp /etc/rancher/k3s/k3s.yaml "$KUBE_HOME/.kube/config"
sudo chown -R "$KUBE_USER:$KUBE_USER" "$KUBE_HOME/.kube"

# /etc/rancher/k3s/k3s.yaml is owned by root.
# The VM user needs to use kubectl without sudo, so we copy it and grant the user ownership of it.
# If the KUBECONFIG environment variable is not set, 
# kubectl reads $HOME/.kube/config by default

# Set kubeconfig automatically whenever the vagrant user logs in.
grep -qxF 'export KUBECONFIG="$HOME/.kube/config"' "$KUBE_HOME/.bashrc" || \
  echo 'export KUBECONFIG="$HOME/.kube/config"' >> "$KUBE_HOME/.bashrc"

sudo chown "$KUBE_USER:$KUBE_USER" "$KUBE_HOME/.bashrc"

# Make token for workers
TOKEN=$(sudo cat /var/lib/rancher/k3s/server/node-token)
echo $TOKEN > "/vagrant/token"

