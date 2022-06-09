#!/usr/bin/env bash

TIMESTAMP=`date -I seconds`
NVIM_CONFIG_DIR=~/.config/nvim
NVIM_CONFIG_BACKUP_DIR=~/.config/nvim.backup.$TIMESTAMP
NVIM_DATA_HOME=~/.local/share/nvim
NVIM_DATA_BACKUP_DIR=~/.local/share/nvim.backup.$TIMESTAMP
DOTFILES_PATH=$( cd "$(dirname "${BASH_SOURCE[0]}")" ; pwd -P )

# check if ~/.config/nvim exists, if not then create it
if [ -d ${NVIM_CONFIG_DIR} ] || [ -L ${NVIM_CONFIG_DIR} ]
then
  echo "Directory ${NVIM_CONFIG_DIR} exists, backing up to ${NVIM_CONFIG_BACKUP_DIR}..."
  mv ${NVIM_CONFIG_DIR} ${NVIM_CONFIG_BACKUP_DIR}
fi
echo "Linking nvim dotfiles to ${NVIM_CONFIG_DIR}"
ln -s $DOTFILES_PATH/nvim $NVIM_CONFIG_DIR

# check if ~/.local/share/nvim exists
if [ -d ${NVIM_DATA_HOME} ] || [ -L ${NVIM_DATA_HOME} ]
then
  echo "Directory ${NVIM_DATA_HOME} exists, backing up to ${NVIM_DATA_BACKUP_DIR}..."
  mv ${NVIM_DATA_HOME} ${NVIM_DATA_BACKUP_DIR}
fi
printf "Creating nvim data directory at ${NVIM_DATA_HOME}\n\n"
mkdir -p $NVIM_DATA_HOME

printf "Downloading vim-plug...\n\n"
# download vimplug.vim from github
curl -fLo "${NVIM_DATA_HOME}"/site/autoload/plug.vim --create-dirs \
       https://raw.githubusercontent.com/junegunn/vim-plug/master/plug.vim

printf '\nInstalling plugins from ~/.config/nvim/init.lua...\n\n'
# install plugins
nvim -es -u ~/.config/nvim/init.lua -i NONE -c "PlugInstall" -c "qa"
nvim -es -u ~/.config/nvim/init.lua -i NONE -c "CocInstall coc-rust-analyzer" -c "qa"