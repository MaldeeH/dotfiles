
wsl

sudo apt update
sudo apt install -y build-essential git curl unzip ripgrep fd-find fzf tmux zsh
sudo add-apt-repository ppa:neovim-ppa/unstable
sudo apt install neovim

git config push.autoSetupRemote true

curl -o- https://raw.githubusercontent.com/nvm-sh/nvm/v0.39.7/install.sh | bash
source ~/.bashrc

nvm install 20
nvm use 20
npm install -g @anthropic-ai/claude-code

mkdir -p ~/code
