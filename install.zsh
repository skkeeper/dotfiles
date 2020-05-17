#!/bin/zsh
if ! [ -x "$(command -v zsh)" ]; then
  echo 'Error: zsh is not installed.' >&2
  exit 1
fi

if ! [ -x "$(command -v git)" ]; then
  echo 'Error: git is not installed.' >&2
  exit 1
fi


sudo apt-get update
sudo apt-get install fd-find silversearcher-ag bat -y
# ripgrep package is broken on ubuntu, for now we download from github
startDir=$(pwd)
cd /tmp
~/.dotfiles/bin/gh-dl-release BurntSushi/ripgrep
sudo dpkg -i ripgrep_*_amd64.deb
rm ripgrep_*_amd64.deb

~/.dotfiles/bin/gh-dl-release dandavison/delta "git-delta_.*_amd64.deb" 
sudo dpkg -i git-delta_*_amd64.deb
rm git-delta_*_amd64.deb

cd "$startDir"

# Install oh-my-zsh
sh -c "$(curl -fsSL https://raw.githubusercontent.com/ohmyzsh/ohmyzsh/master/tools/install.sh)" "" --unattended
rm ~/.zshrc.pre-oh-my-zsh
mv ~/.zshrc.pre-oh-my-zsh ~/.zshrc

git clone https://github.com/zsh-users/zsh-autosuggestions ${ZSH_CUSTOM:-~/.oh-my-zsh/custom}/plugins/zsh-autosuggestions
git clone https://github.com/zsh-users/zsh-syntax-highlighting.git ${ZSH_CUSTOM:-~/.oh-my-zsh/custom}/plugins/zsh-syntax-highlighting
chmod -R 751 ~/.oh-my-zsh/custom/plugins/zsh-autosuggestions
chmod -R 751 ~/.oh-my-zsh/custom/plugins/zsh-syntax-highlighting

#powerlevel10k
git clone --depth=1 https://github.com/romkatv/powerlevel10k.git ${ZSH_CUSTOM:-~/.oh-my-zsh/custom}/themes/powerlevel10k

# Install FZF
git clone --depth 1 https://github.com/junegunn/fzf.git ~/.fzf
~/.fzf/install --no-key-bindings --no-completion --no-update-rc

# Tmux
sudo apt-get install tmux -y
git clone https://github.com/tmux-plugins/tpm ~/.tmux/plugins/tpm
ln -s .dotfiles/tmux.conf ~/.tmux.conf
