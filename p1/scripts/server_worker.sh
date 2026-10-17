#!/bin/bash
curl -sfL https://get.k3s.io | sh -
k3s agent --server "192.168.56.110"