#!/bin/bash
set -ex

echo "Unset the default variables"
unset http_proxy
unset https_proxy
unset HTTP_PROXY
unset HTTPS_PROXY
echo "Removing all the chain"
sudo iptables -F OUTPUT
