#!/usr/bin/env bash
PACKER_DIR=~/.local/share/nvim/site/pack/packer/start/packer.nvim
if [ ! -d "$PACKER_DIR" ]; then
  echo "packer.nvim not found, cloning into $PACKER_DIR"
  git clone --depth 1 https://github.com/wbthomason/packer.nvim ~/.local/share/nvim/site/pack/packer/start/packer.nvim
else
    echo "packer.nvim already exists at $PACKER_DIR, skipping"
fi
nvim --headless -c 'autocmd User PackerComplete quitall' -c 'PackerSync'

