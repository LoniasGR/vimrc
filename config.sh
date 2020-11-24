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

# Check Linux release
if [ "${machine}" = "Linux" ]; then
	release="$(cat /etc/*release | grep PRETTY_NAME=)"
	case "${release}" in
		*CentOS*)	distro=CentOS;;
		*Ubuntu*)	distro=Ubuntu;;
		*Debian*)	distro=Debian;;
		*)		distro="Other";
	esac
fi

echo 'Linux distribution is' ${release}
# Change to HOME 
cd ~

# Get needed dependencies
if [ "${machine}" = "Linux" ]; then
	if [ "${distro}" = "Ubuntu" ] || [ "${distro}" = "Debian" ]; then
		sudo apt-get install -y python3 curl vim
	fi
	if [ "${distro}" = "CentOS" ]; then
		sudo dnf install -y python3 curl vim
	fi
fi 

# Create needed directories

mkdir ${VIMFOLDER}

# Copy files
cp vimrc${SLASH}vimrc ${HOME}${SLASH}.vimrc

# Install pathogen
mkdir -p ${VIMFOLDER}${SLASH}autoload ${VIMFOLDER}${SLASH}bundle && \
	curl -LSso ${VIMFOLDER}${SLASH}autoload${SLASH}pathogen.vim https://tpo.pe/pathogen.vim

cd ~/.vim/bundle && git clone --branch v1.7 https://github.com/nanotech/jellybeans.vim.git

cd ${HOME}

# Test everything is working
# TODO: Add more tests other than colors
python3 vimrc${SLASH}colortest.py
