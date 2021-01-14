#!/bin/bash

bash ./install_requirements.sh 

# Change to HOME 
CURRDIR=`pwd`
cd ${HOME}

VIMVERSION="$(vim --version | head -1 | cut -d ' ' -f 5) | cut -f1 -d'.'"

if [$VIMVERSION != "8"]; then 
    git clone https://github.com/vim/vim.git
    cd src
    make distclean  # if you build Vim before
    make
    if [[ $EUID -eq 0 ]]; then
        make install
    else 
        sudo make install
    fi
fi

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
