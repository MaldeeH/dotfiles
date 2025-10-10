# dotfiles
secret sauce

# get wsl (ubuntu is default)
wsl

# Setting up wsl:
sudo apt update
sudo apt install -y build-essential git curl unzip ripgrep fd-find fzf

##Configure git:
git config push.autoSetupRemote true

## TMUX
sudo apt install -y tmux

## Neovim
sudo add-apt-repository ppa:neovim-ppa/unstable
sudo apt update
sudo apt install neovim

## Nvm/npm (needed for claude code)
curl -o- https://raw.githubusercontent.com/nvm-sh/nvm/v0.39.7/install.sh | bash
# load it in this shell (or open a new terminal)
source ~/.bashrc
nvm install 20
nvm use 20

##Claude code
npm install -g @anthropic-ai/claude-code

## comfy workspace
mkdir -p ~/code

### drag and drop repositories via windows explorer into the code folder on wsl
from
C:\dev
into
\\wsl.localhost\Ubuntu\home\maldee\code

Import the various config files
