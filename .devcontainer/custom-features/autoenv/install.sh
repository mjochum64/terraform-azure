#!/usr/bin/env bash
set -e

install -m 755 ./activate-autoenv.sh /usr/local/bin/activate-autoenv.sh

echo "source /usr/local/bin/activate-autoenv.sh" >> /etc/bash.bashrc
if [[ -f /etc/zsh/zshrc ]]
then
  echo "source /usr/local/bin/activate-autoenv.sh" >> /etc/zsh/zshrc
fi