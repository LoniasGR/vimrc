#!/bin/sh

# Check the OS we are running on
UNAME="$(uname -s)"


case "${UNAME}" in
	Linux*)     OS=Linux;;
	Darwin*)    OS=Mac;;
	CYGWIN*)    OS=Cygwin;;
	MINGW*)     OS=MinGw;;
	*)          OS="UNKOWN"
esac

echo 'Working on' ${OS}

# Exit if we can't figure the OS
if [ "${OS}" = "UKNOWN" ]; then
	echo 'Uknown type of OS:'
	uname -s
	exit 1
fi


if [ "${OS}" = "Linux" ]  || [ "${OS}" = "Mac" ]; then
	VIMFOLDER="${HOME}/.vim"


else 
	VIMFOLDER="~\vimfiles"
fi

# Check Linux release
if [ "${OS}" = "Linux" ]; then
	release="$(cat /etc/*release | grep PRETTY_NAME=)"
	case "${release}" in
		*CentOS*)	DISTRO=CentOS;;
		*Ubuntu*)	DISTRO=Ubuntu;;
		*Debian*)	DISTRO=Debian;;
		*)		DISTRO="Other";
	esac
fi

echo 'Linux distribution is' ${release}



# Get needed dependencies
if [ "${OS}" = "Linux" ]; then
	if [ "${DISTRO}" = "Ubuntu" ] || [ "${DISTRO}" = "Debian" ]; then
		sudo apt-get install -y python3 curl vim
	fi
	if [ "${DISTRO}" = "CentOS" ]; then
		sudo dnf install -y python3 curl vim
	fi
fi 

VIMVERSION="$(vim --version | head -1 | cut -d ' ' -f 5)"
echo 'Current VIM version installed is' ${VIMVERSION}

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
