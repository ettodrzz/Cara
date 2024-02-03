# Bash

### Prerequisites

1. **[cURL](https://curl.se/)**

Check the installed version.

```bash
curl --version
```

If it isn't installed, install the curl package.

```bash
sudo pacman -S curl
```

### Installation

Download the configuration file, also download a script that customizes the prompt and the window title.

```bash
curl --create-dirs -o ~/.bashrc https://raw.githubusercontent.com/ettodrzz/Cara/main/arch/bashrc -o ~/.scripts/bash_prompt.sh https://raw.githubusercontent.com/ettodrzz/Cara/main/arch/scripts/bash_prompt.sh
```

Reopen the terminal, or source the bashrc file.

```bash
source ~/.bashrc
```
