#!/bin/bash

bash ./install_requirements.sh

curl -sLf https://spacevim.org/install.sh | bash

rm ${HOME}/.SpaceVim.d/init.toml || mkdir -p ${HOME}/.SpaceVim.d/
cp ./init.toml ${HOME}/.SpaceVim.d/
