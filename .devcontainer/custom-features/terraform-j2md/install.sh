#!/usr/bin/env bash
set -e

# VERSION is set from options in devcontainer-feature.json
VERSION=v${VERSION}

wget https://github.com/reproio/terraform-j2md/releases/download/${VERSION}/terraform-j2md_Linux_x86_64.tar.gz -O terraform-j2md.tar.gz
tar -xvzf terraform-j2md.tar.gz terraform-j2md
sudo install -m 755 terraform-j2md /usr/local/bin/terraform-j2md
rm terraform-j2md terraform-j2md.tar.gz