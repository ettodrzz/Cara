# Linux Mint

### Alacritty

[Installation](https://github.com/alacritty/alacritty/blob/master/INSTALL.md)

**Restore the configuration file**:

```bash
curl --create-dirs --output ~/.config/alacritty/alacritty.toml https://raw.githubusercontent.com/ettodrzz/Cara/main/Linux/alacritty.toml
```

### Git

**Install from the package manager**:

```bash
sudo apt install git
```

*Check the installed version with `git --version`*.

**Set up the configuration file**:
    
- Set your user name and email address:

```bash
git config --global user.name "John Doe"
git config --global user.email johndoe@example.com
```

- Change the default editor:

```bash
git config --global core.editor nvim
```

- Change the default branch name when initializing a new repository:

```bash
git config --global init.defaultBranch main
```

*Check the configuration with `git config --list`*.

### Neovim

**Install from the package manager**:

```bash
sudo apt install neovim
```

*Check the installed version with `nvim --version`*.

**Restore the configuration file**:

```bash
curl --create-dirs --output ~/.config/nvim/init.vim https://raw.githubusercontent.com/ettodrzz/Cara/main/Linux/init.vim
```

### NVM

Before continuing [Git](https://github.com/ettodrzz/Cara#git) must be installed.

**Clone the repository in the root**:

```bash
git clone https://github.com/nvm-sh/nvm.git ~/.nvm
```

**Uncomment or add the next lines in the .bashrc file to have it automatically sourced upon login**:

```bash
export NVM_DIR="$HOME/.nvm"
[ -s "$NVM_DIR/nvm.sh" ] && \. "$NVM_DIR/nvm.sh"  # This loads nvm
[ -s "$NVM_DIR/bash_completion" ] && \. "$NVM_DIR/bash_completion"  # This loads nvm bash_completion
```

Reopen the terminal to get NVM ready.
