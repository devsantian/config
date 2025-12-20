#!/bin/bash

# You need a terminal which supports true color and undercurl
# My personal preference is:  https://github.com/kovidgoyal/kitty
echo "######## Starting pre-installation configs for lazyvim..."
cd ~

echo "######## Updating apt"
sudo apt update -y && sudo apt upgrade -y

echo "######## Building essentials..."
# Added xclip for clipboard and unzip for plugin extraction
sudo apt install -y build-essential clang llvm curl git fzf ripgrep fd-find luarocks xclip unzip

echo "######## Downloading lazygit..."
sudo apt install -y lazygit

echo "######## Installing rust..."
# Added -s -- -y to accept default installation automatically
curl --proto '=https' --tlsv1.2 -sSf https://sh.rustup.rs | sh -s -- -y
# Source cargo immediately so the rest of the script can use it
source "$HOME/.cargo/env"

echo "######## Installing tectonic..."
curl --proto '=https' --tlsv1.2 -fsSL https://drop-sh.fullyjustified.net | sh
# Moving the binary to a path location
sudo mv tectonic /usr/local/bin/

echo "######## Installing tree-sitter-cli..."
~/.cargo/bin/cargo install --locked tree-sitter-cli

echo "######## Installing nvim..." 
# 1. Download the archive
curl -LO https://github.com/neovim/neovim/releases/latest/download/nvim-linux-x86_64.tar.gz

# 2. Prepare the directories
mkdir -p ~/.local/bin
mkdir -p ~/.local/lib/nvim

# 3. Extract exactly into the lib directory
# --strip-components=1 ensures 'bin' and 'share' are directly inside ~/.local/lib/nvim
tar -C ~/.local/lib/nvim --strip-components=1 -xzf nvim-linux-x86_64.tar.gz

# 4. Create the symlink in bin
ln -sf ~/.local/lib/nvim/bin/nvim ~/.local/bin/nvim

# 5. Clean up
rm nvim-linux-x86_64.tar.gz

echo "######## Updating PATH in .zshrc"
# Only add if not already present
if ! grep -q ".local/bin" ~/.zshrc; then
  echo 'export PATH="$HOME/.local/bin:$PATH"' >> ~/.zshrc
fi

echo "######## Installing lazyvim"
# Remove old config to prevent git clone failure
rm -rf ~/.config/nvim
git clone https://github.com/LazyVim/starter ~/.config/nvim

echo "######## Installation Complete!"
echo "RUN 'source ~/.zshrc' THEN 'nvim' TO FINISH SETUP."
