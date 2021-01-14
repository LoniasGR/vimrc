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
  	if [[ $EUID -eq 0 ]]; then
    	apt-get install -y python3 curl vim fontconfig xfonts-utils
	else
	    sudo apt-get install -y python3 curl vim fontconfig xfonts-utils
	fi
  fi
  if [ "${DISTRO}" = "CentOS" ]; then
    sudo dnf install -y python3 curl vim
  fi
fi 

VIMVERSION="$(vim --version | head -1 | cut -d ' ' -f 5)"
echo 'Current VIM version installed is' ${VIMVERSION}
