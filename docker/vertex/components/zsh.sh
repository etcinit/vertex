#!/bin/sh

# Setup ZSH
echo "[VERTEX] Setting up ZSH..."
apt-get install zsh
git clone git://github.com/robbyrussell/oh-my-zsh.git /vertex/.oh-my-zsh
chmod go+rx /vertex/.oh-my-zsh
