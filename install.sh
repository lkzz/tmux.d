#!/bin/bash

BASEDIR=$(dirname $0)
cd $BASEDIR
CURRENT_DIR=`pwd`

lnif() {
    if [ -e "$1" ]; then
        ln -sf "$1" "$2"
    fi
}

echo "Step1: backing up current tmux config"
today=`date +%Y%m%d`
for i in ~/.tmux.conf; do [ -e $i ] && [ ! -L $i ] && mv $i $i.$today; done

echo "Step2: setting up symlinks"
lnif $CURRENT_DIR/tmux.conf ~/.tmux.conf

echo "Step3: install plugin manager"
rm -rf ~/.tmux/plugins
git clone https://github.com/tmux-plugins/tpm ~/.tmux/plugins/tpm

echo "Step4: install plugins"
export TMUX_PLUGIN_MANAGER_PATH="~/.tmux/plugins"
~/.tmux/plugins/tpm/bin/install_plugins
export TMUX_PLUGIN_MANAGER_PATH=""

echo "Step5: brew install reattach-to-user-namespace"
brew install reattach-to-user-namespace
