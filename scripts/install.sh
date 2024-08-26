#!/bin/bash
set -e

scripts_dir="$(dirname -- "$(readlink -f ${BASH_SOURCE[0]})")"
ARCADIA_HOME=/opt/arcadia
# GITHUB_REPO_LOCATION=/tmp/arcadia-setup/$(date '+%Y%m%d%H%M%S')
GITHUB_REPO=git@github.com:netologist/arcadia.git
BREWFILE=$GITHUB_REPO_LOCATION/scripts/configuration/homebrew/Brewfile

make_brewfile() {
  grep "tags:\s*['\"]\S.*\S.*['\"]" $BREWFILE | grep $1
}

if ! command -v gcc &> /dev/null
then
    echo "Info   | Install   | XCode"
    xcode-select --install
else
    echo "✅ XCode already installed"
fi

# Download and install Homebrew
if ! command -v brew &> /dev/null
then
    echo "Info   | Install   | Homebrew"
    /bin/bash -c "$(curl -fsSL https://raw.githubusercontent.com/Homebrew/install/HEAD/install.sh)"
else
    echo "✅ Homebrew already installed"
fi

if ! command -v git &> /dev/null
then
    echo "Info   | Install   | Git"
    brew update
    brew install git
else
    echo "✅ Git already installed"
fi

sudo mkdir -p ${ARCADIA_HOME}/projects
sudo chown -R $(whoami) ${ARCADIA_HOME}
git clone https://github.com/netologist/arcadia.git ${ARCADIA_HOME}/home

# Install || Update Core Utils
echo "Info   | Install   | Core utils"
brew update
brew bundle --file <(make_brewfile "core") 2> /dev/null

# echo "eval \"\$(starship init zsh)\"\n" >> $HOME/.zshrc

# Install OhMyZsh
# sh -c "$(curl -fsSL https://raw.githubusercontent.com/ohmyzsh/ohmyzsh/master/tools/install.sh)"

# # Set Keybindings
# ./set_keybindings.sh

# # Set Starship
# echo "eval \"\$(starship init zsh)\"\n" >> ~/.zshrc

# # Install RustUp
# curl --proto '=https' --tlsv1.2 -sSf https://sh.rustup.rs | sh

# . "$HOME/.cargo/env"   


# # Install OhMyZsh

# sh -c "$(curl -fsSL https://raw.githubusercontent.com/ohmyzsh/ohmyzsh/master/tools/install.sh)"

# git clone https://github.com/zsh-users/zsh-autosuggestions ${ZSH_CUSTOM:-~/.oh-my-zsh/custom}/plugins/zsh-autosuggestions
# git clone https://github.com/zsh-users/zsh-syntax-highlighting.git ${ZSH_CUSTOM:-~/.oh-my-zsh/custom}/plugins/zsh-syntax-highlighting


# ## example for zsh settings.
# ```zsh
# # Path to your oh-my-zsh installation.
# export ZSH="$HOME/.oh-my-zsh"

# ZSH_THEME="robbyrussell"

# plugins=(
#   git
#   zsh-autosuggestions
#   zsh-syntax-highlighting
# )

# source $ZSH/oh-my-zsh.sh

# # Enable completion
# autoload -Uz compinit
# compinit
# ```

# v=$(echo " option 1 \n option 2" | sort -r | fzf --no-preview)
# echo $v
