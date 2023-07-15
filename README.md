# Linux Mint

### Alacritty

1. [Installation](https://github.com/alacritty/alacritty/blob/master/INSTALL.md)

2. Restore the configuration file:

```bash
curl --create-dirs --output ~/.config/alacritty/alacritty.toml https://raw.githubusercontent.com/ettodrzz/Cara/main/Linux/alacritty.toml
```

### Neovim

1. Install from package:

```bash
sudo apt install neovim
```

2. Restore the configuration file:

```bash
curl --create-dirs --output ~/.config/nvim/init.vim https://raw.githubusercontent.com/ettodrzz/Cara/main/Linux/init.vim
```

### NVM

1. Clone the repository in the root:

```bash
git clone https://github.com/nvm-sh/nvm.git ~/.nvm
```

2. Uncomment the next lines on the .bashrc file to have it automatically sourced upon login:

```bash
export NVM_DIR="$HOME/.nvm"
[ -s "$NVM_DIR/nvm.sh" ] && \. "$NVM_DIR/nvm.sh"  # This loads nvm
[ -s "$NVM_DIR/bash_completion" ] && \. "$NVM_DIR/bash_completion"  # This loads nvm bash_completion
```

3. Activate NVM by sourcing it in the actual shell:

```bash
source ~/.nvm/nvm.sh
```

*Or reopen the terminal*.
