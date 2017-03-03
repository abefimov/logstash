#!/bin/bash
set -ex
current_dir="$(dirname "$0")"
sudo apt-get install -y squid3 net-tools
sudo iptables -A OUTPUT -p tcp --dport 80 -m owner --uid-owner proxy -j ACCEPT
sudo iptables -A OUTPUT -p tcp --dport 443 -m owner --uid-owner proxy -j ACCEPT
sudo iptables -A OUTPUT -p tcp --dport 80 -m owner --uid-owner root -j ACCEPT
sudo iptables -A OUTPUT -p tcp --dport 443 -m owner --uid-owner root -j ACCEPT
sudo iptables -A OUTPUT -p tcp --dport 443 -j REJECT
sudo iptables -A OUTPUT -p tcp --dport 80 -j REJECT

echo "Connecting to a remote host should fails without proxy"
curl -I "http://rubygems.org"

echo "Connecting to a remote host with a valid proxy should succeed"
export http_proxy=http://localhost:3128
export https_proxy=http://localhost:3128
export HTTP_PROXY=http://localhost:3128
export HTTPS_PROXY=http://localhost:3128
curl -I "https://rubygems.org"
