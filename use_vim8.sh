#!/bin/bash

bash ./install_requirements.sh 

# Change to HOME 
CURRDIR=`pwd`
cd ${HOME}

# Create needed directories
mkdir ${VIMFOLDER}

# Copy files
cp ${CURRDIR}/vimrc ${HOME}/.vimrc

# Install Jellybeans colorscheme
mkdir -p ${HOME}/.vim/colors
cd ${HOME}/.vim/colors
curl -O https://raw.githubusercontent.com/nanotech/jellybeans.vim/master/colors/jellybeans.vim

# Install nginx colors
mkdir -p ~/.vim/pack/plugins/start
cd ~/.vim/pack/plugins/start
git clone https://github.com/chr4/nginx.vim.git

cd ${HOME}

# Test everything is working
# TODO: Add more tests other than colors
python3 ${CURRDIR}/tests/colortest.py
