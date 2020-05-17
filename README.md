# dotfiles

## Requirements

- [homeshick](https://github.com/andsens/homeshick)
- zsh

## Install

- Install homeshick

```bash
git clone https://github.com/andsens/homeshick.git $HOME/.homesick/repos/homeshick
printf '\nsource "$HOME/.homesick/repos/homeshick/homeshick.sh"' >> $HOME/.bashrc
```

- Install zsh (the install script needs it)

- Clone this repo with homeshick

```bash
homeshick clone skkeeper/dotfiles
```

- Run `install.zsh`

```bash
homeshick cd dotfiles
./install.zsh
```
