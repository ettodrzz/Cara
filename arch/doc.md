# Nerd Font

Get the latest version name:

```bash
curl https://api.github.com/repos/ryanoasis/nerd-fonts/releases | jq '.[0].name'
```

List all available fonts:

```bash
curl https://api.github.com/repos/ryanoasis/nerd-fonts/releases | jq '.[0].assets.[].name'
```

Download font on the tmp directory:

E.g.

| Variable  | Value       |
| --------- | ----------- |
| version   | v3.1.1      |
| font      | Hack.tar.xz |

```bash
cd /tmp
wget https://github.com/ryanoasis/nerd-fonts/releases/download/[version]/[font-name]
```

Decompress xz file:

```bash
unxz Hack.tar.xz
```

Decompress tar file:

```bash
mkdir Hack
tar -xf Hack.tar -C Hack
```

Install font:

```bash
cp -r Hack ~/.local/share/fonts/Hack
fc-cache
```

# Bash

Restore the configuration:

```bash
curl --create-dirs -o ~/.bashrc https://raw.githubusercontent.com/ettodrzz/Cara/main/arch/bashrc -o ~/.scripts/bash_prompt.sh https://raw.githubusercontent.com/ettodrzz/Cara/main/arch/scripts/bash_prompt.sh
```

Reopen the terminal, or source the bashrc file to see the changes:

```bash
source ~/.bashrc
```

# Nano

Restore the configuration:

```bash
curl -o ~/.nanorc https://raw.githubusercontent.com/ettodrzz/Cara/main/arch/nanorc
```
