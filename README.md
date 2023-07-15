# Linux Mint

### Alacritty

Before continuing [Git](https://github.com/ettodrzz/Cara#git) and [Rustup](https://github.com/ettodrzz/Cara#rustup) must be installed.

Install the dependencies from the package manager:

```bash
sudo apt install cmake pkg-config libfreetype6-dev libfontconfig1-dev libxcb-xfixes0-dev libxkbcommon-dev python3
```

Clone the Alacritty repository in the Downloads directory:

```bash
git clone https://github.com/alacritty/alacritty.git ~/Downloads/alacritty
```

Compile local packages and all of their dependencies:

```bash
cd ~/Downloads/alacritty
cargo build --release
```

Install the terminfo globally:

```bash
sudo tic -xe alacritty,alacritty-direct extra/alacritty.info
```

Install the desktop entry:

```bash
sudo cp target/release/alacritty /usr/local/bin # or anywhere else in $PATH
sudo cp extra/logo/alacritty-term.svg /usr/share/pixmaps/Alacritty.svg
sudo desktop-file-install extra/linux/Alacritty.desktop
sudo update-desktop-database
```

Restore the configuration file:

```bash
curl --create-dirs --output ~/.config/alacritty/alacritty.toml https://raw.githubusercontent.com/ettodrzz/Cara/main/Linux/alacritty.toml
```

### Bash

The `.bashrc` file is a shell script that is executed every time you open a new terminal.

The `.profile` file is also a shell script, but it is executed before the `.bashrc` file, when you log in to your account.

Restore both files:

```bash
curl --create-dirs --output ~/.bashrc https://raw.githubusercontent.com/ettodrzz/Cara/main/Linux/.bashrc
curl --create-dirs --output ~/.profile https://raw.githubusercontent.com/ettodrzz/Cara/main/Linux/.profile
```

Reopen the terminal to see the changes.

### Git

Install from the package manager:

```bash
sudo apt install git
```

*Check the installed version with `git --version`*.

Set up the configuration file:
    
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

Install from the package manager:

```bash
sudo apt install neovim
```

*Check the installed version with `nvim --version`*.

Restore the configuration file:

```bash
curl --create-dirs --output ~/.config/nvim/init.vim https://raw.githubusercontent.com/ettodrzz/Cara/main/Linux/init.vim
```

### NVM

Stands for Node Version Manager. It is a tool that allows you to install, manage and switch between different version of Node.js.

Before continuing [Git](https://github.com/ettodrzz/Cara#git) must be installed.

Clone the repository in the root:

```bash
git clone https://github.com/nvm-sh/nvm.git ~/.nvm
```

Uncomment or add the next lines in the [bashrc file](https://github.com/ettdrzz/Cara#bash) to have it automatically sourced upon login:

```bash
export NVM_DIR="$HOME/.nvm"
[ -s "$NVM_DIR/nvm.sh" ] && \. "$NVM_DIR/nvm.sh"  # This loads nvm
[ -s "$NVM_DIR/bash_completion" ] && \. "$NVM_DIR/bash_completion"  # This loads nvm bash_completion
```

Reopen the terminal to get NVM ready.

Download, compilate, and install the LTS (Long-Term Support) Node version:

```bash
nvm install --lts
```

*Check the installed versions of Node and NPM (Node Package Manager) with `node --version && npm --version`*.

### Rustup

Is a tool that helps you install, manage, and update the Rust programming language. Tools are installed to the `~/.cargo/bin` directory, and this is where you will find the Rust toolchain, including `rustrc`, `cargo`, and `rustup`.

Install from the installation script:

```bash
curl https://sh.rustup.rs -sSf | sh -s -- --default-host x86_64-unknown-linux-gnu --default-toolchain stable --profile minimal --no-modify-path
```

Uncomment or add the next line in the [bashrc file](https://github.com/ettodrzz/Cara#bash) to have it automatically sourced upon login:

```bash
source "$HOME/.cargo/env"
```

Reopen the terminal to get Rustup ready.
