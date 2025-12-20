# You need a terminal which su$pports true color and undercurl
# My personal prefference is:  https://github.com/kovidgoyal/kitty
echo "########Starting pre-installation configs for lazyvim..."
cd ~

echo "######## Updating apt"
sudo apt update -y && apt upgrade -y

echo "######## Building essentials..."
sudo apt install -y build-essential clang llvm curl git fzf ripgrep fd-find luarocks


echo "######## Downloading lazygit..."
sudo apt install -y lazygit

echo "######## Installing rust..."
curl --proto '=https' --tlsv1.2 -sSf https://sh.rustup.rs | sh # we install rust for some packages. NPM is also an alternative.

echo "######## Installing tectonic..."
curl --proto '=https' --tlsv1.2 -fsSL https://drop-sh.fullyjustified.net |sh

echo "######## Installing tree-sitteri-cli..."
~/.cargo/bin/cargo install --locked tree-sitter-cli

echo "######## Installing nvim..." 
curl -LO https://github.com/neovim/neovim/releases/latest/download/nvim-linux-x86_64.tar.gz

echo "######## Do not forget to update path ;)"
export PATH="$PATH:/opt/nvim-linux-x86_64/bin" #!!!! ADD THIS TO ~/.zshrc or ~/.bashrc

echo "######## Installing lazyvim"
git clone https://github.com/LazyVim/starter ~/.config/nvim
