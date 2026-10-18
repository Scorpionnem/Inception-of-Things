#!/bin/bash
curl -sfL https://get.k3s.io | sh -

TOKEN=$(sudo cat /var/lib/rancher/k3s/server/node-token)
echo $TOKEN > /vagrant/token