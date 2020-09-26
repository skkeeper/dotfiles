#!/bin/zsh
if ! [ -x "$(command -v zsh)" ]; then
  echo 'Error: zsh is not installed.' >&2
  exit 1
fi

if ! [ -x "$(command -v git)" ]; then
  echo 'Error: git is not installed.' >&2
  exit 1
fi

if [ -n "$(command -v apt-get)" ]; then
  echo 'Assuming debian based distro'
  sudo apt-get update
  sudo apt-get install fd-find silversearcher-ag ripgrep bat tmux -y
  
  startDir=$(pwd)
  cd /tmp

  ~/.dotfiles/bin/gh-dl-release dandavison/delta "git-delta_.*_amd64.deb" 
  sudo dpkg -i git-delta_*_amd64.deb
  rm git-delta_*_amd64.deb

  cd "$startDir"
fi

if [ -n "$(command -v dnf)" ]; then
   echo 'Assuming rpm based distro'
  sudo dnf install fd-find the_silver_searcher ripgrep bat tmux git-delta -y
fi



# Install oh-my-zsh
sh -c "$(curl -fsSL https://raw.githubusercontent.com/ohmyzsh/ohmyzsh/master/tools/install.sh)" "" --unattended
rm ~/.zshrc
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
git clone https://github.com/tmux-plugins/tpm ~/.tmux/plugins/tpm
ln -s .dotfiles/tmux.conf ~/.tmux.conf

# NVM
curl -o- https://raw.githubusercontent.com/nvm-sh/nvm/v0.35.3/install.sh | bash

