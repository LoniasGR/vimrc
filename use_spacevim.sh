#!/bin/bash

bash ./install_requirements.sh

curl -sLf https://spacevim.org/install.sh | bash

mkdir -p ${HOME}/.SpaceVim.d/
rm ${HOME}/.SpaceVim.d/init.toml
cp ./init.toml ${HOME}/.SpaceVim.d/
