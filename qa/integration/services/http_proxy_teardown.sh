#!/bin/bash
set -ex

unset http_proxy
unset https_proxy
unset HTTP_PROXY
unset HTTPS_PROXY
sudo iptables -F
