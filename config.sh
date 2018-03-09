#!/bin/sh

# Check the machine we are running on
unameOut="$(uname -s)"

case "${unameOut}" in
    Linux*)     machine=Linux;;
    Darwin*)    machine=Mac;;
    CYGWIN*)    machine=Cygwin;;
    MINGW*)     machine=MinGw;;
    *)          machine="UNKOWN"
esac

echo 'Working on' ${machine}

# Exit if we can't figure the machine
if [ "${machine}" = "UKNOWN" ]; then
    echo 'Uknown type of machine:'
    uname -s
    exit 1
fi


if [ "${machine}" = "Linux" ]  || [ "${machine}" = "Mac" ]; then
    VIMFOLDER="${HOME}/.vim"
    SLASH="/"
else 
    VIMFOLDER="~\vimfiles"
    SLASH="\\"
fi
    
# Change to HOME 
cd ~

# Get needed dependencies
if [ "${machine}" = "Linux" ]; then
    sudo apt-get install python curl
fi 

# Create needed directories

mkdir ${VIMFOLDER}
mkdir ${VIMFOLDER}${SLASH}colors

# Copy files
cp vimrc${SLASH}vimrc ${HOME}${SLASH}.vimrc
cp vimrc${SLASH}jellybeans.vim \
    ${VIMFOLDER}${SLASH}colors${SLASH}jellybeans.vim

# Install pathogen
mkdir -p ${VIMFOLDER}${SLASH}autoload ${VIMFOLDER}${SLASH}bundle && \
    curl -LSso ${VIMFOLDER}${SLASH}autoload${SLASH}pathogen.vim https://tpo.pe/pathogen.vim

# Test everything is working
# TODO: Add more tests other than colors
python vimrc${SLASH}colortest.py
