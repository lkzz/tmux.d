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
for i in $HOME/.tmux.conf; do [ -e $i ] && [ ! -L $i ] && mv $i $i.$today; done

echo "Step2: setting up symlinks"
lnif $CURRENT_DIR/tmux.conf $HOME/.tmux.conf

echo "Step3: git clone plugin:tpm"
rm -rf $HOME/.tmux/plugins
git clone https://github.com/tmux-plugins/tpm $HOME/.tmux/plugins/tpm

echo "Step4: source tpm plugin"
tmux source $HOME/.tmux.conf
