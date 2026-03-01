#!/bin/bash

# --- 1. Package Installation ---
echo "Installing core tools..."

# Detect package manager and install basics
if command -v apt &> /dev/null; then
    sudo apt update
    sudo apt install -y neofetch git nano wget curl tree gh python3.12-venv
elif command -v dnf &> /dev/null; then
    sudo dnf install -y neofetch git nano wget curl tree gh python3.12-venv
fi

# Installing nerd font
# 1. Define variables
FONT_URL="https://github.com/ryanoasis/nerd-fonts/releases/download/v3.4.0/ProFont.zip"
FONT_DIR="$HOME/.local/share/fonts/ProFont"
TEMP_DIR=$(mktemp -d)

echo "Downloading and installing ProFont Nerd Font..."

# 2. Create the font directory if it doesn't exist
mkdir -p "$FONT_DIR"

# 3. Download the zip to the temporary directory
wget -O "$TEMP_DIR/ProFont.zip" "$FONT_URL"

# 4. Unzip only the font files (.ttf and .otf) into the font folder
unzip "$TEMP_DIR/ProFont.zip" -d "$TEMP_DIR"
mv "$TEMP_DIR"/*.{ttf,otf} "$FONT_DIR/" 2>/dev/null

# 5. Update the system font cache
fc-cache -fv

# 6. Cleanup: Remove the temporary directory and all its contents
rm -rf "$TEMP_DIR"


# --- 2. Configuration Setup ---
BASHRC="$HOME/.bashrc"
echo "Configuring $BASHRC..."

# Create a backup with a timestamp
cp "$BASHRC" "$BASHRC.bak.$(date +%F_%T)"

# Overwrite with your custom environment
# Note: Use 'EOF' to prevent the script from expanding $HOME or $PS1 now
cat << 'EOF' > "$BASHRC"
# ~/.bashrc - Custom Environment

# UI/UX Improvements
export EDITOR='nano'
export HISTSIZE=10000
alias ls='ls --color=auto'
alias grep='grep --color=auto'

# Navigation Shortcuts
alias ..='cd ..'
alias ...='cd ../..'
alias h='history'

# Git Shortcuts
alias gst='git status'
alias gp='git pull'

# Update command alias
if command -v apt &> /dev/null; then
    alias updater='sudo apt update && sudo apt dist-upgrade -y && flatpak update'
elif command -v dnf &> /dev/null; then
    alias updater='sudo dnf update && sudo dnf upgrade'
fi
alias autoremove='sudo apt autoremove -y'

# Python aliases
alias python='python3'
alias pyhon='python'
alias pyven='source $HOME/.venv/bin/activate'

### Detect Linux Distro ###
if command -v grep &> /dev/null && [ -f /etc/os-release ]; then
    distro_id=$(grep '^ID=' /etc/os-release | cut -d= -f2 | tr -d
'"')
else
    distro_id="unknown"
fi

### Set Distro Icon ###
case "$distro_id" in
  kali) DISTRO_ICON="<U+F327>" ;;   # Kali Linux
  arch*) DISTRO_ICON="<U+E732>" ;;   # Arch Linux
  ubuntu) DISTRO_ICON="<U+F31B>" ;; # Ubuntu
  debian) DISTRO_ICON="<U+F306>" ;; # Debian
  fedora) DISTRO_ICON="<U+F30A>" ;; # Fedora
  alpine) DISTRO_ICON="<U+F300>" ;; # Alpine
  void) DISTRO_ICON="<U+F32E>" ;;   # Void Linux
  opensuse*|sles) DISTRO_ICON="<U+F314>" ;; # openSUSE
  gentoo) DISTRO_ICON="<U+F30D>" ;; # Gentoo
  nixos) DISTRO_ICON="<U+F313>" ;; # NixOS
  linuxmint) DISTRO_ICON="<U+F17C>" ;;  # Mint
  *) DISTRO_ICON=" " ;;                
esac

### Username ###
if [[ -n "$PREFIX" && "$PREFIX" == */com.termux/* ]]; then
USER_NAME=cogy
else
USER_NAME="$(whoami)"
fi

### Build PS1 with proper escaping ###
PS1='\[\e[1;32m\]╭─\[\e[1;34m\][\[\e[1;36m\]'"${USER_NAME}"'\[\e[1
;33m\] '"${DISTRO_ICON}"' \[\e[1;36m\]\h\[\e[1;34m\]] [\[\e[1;33m\]\w\[\e[1;34m\]]\[\e[0m\]
\[\e[1;32m\]╰─❯\[\e[0m\] '

[[ -f /data/data/com.termux/files/home/.shell_rc_content ]] && source /data/data/com.termux/files/home/.shell_rc_content
[[ -f /data/data/com.termux/files/home/.aliases ]] && source /data/data/com.termux/files/home/.aliases
alias pyven='source ~/.venv/bin/activate'
alias python='python3'

# Add neofetch to the bottom for the sys info art
neofetch
EOF

# --- 3. Finalization ---
echo "Success! Your environment is ready."
echo "Run: source ~/.bashrc"

# --- 4. Setup Python Environment
cd "$HOME" || exit
python_env="$HOME/.venv"

if [[ -d "$python_env" ]]; then
    echo "Python environment exisit at $python_env"
    read -rp "Would you like to reinstall it? (y/n): " yn
    case $yn in
        [Yy]* ) 
            echo "Proceeding with the installation..."
            rm -Rf .venv
            python3 -m venv .venv
            exit
            ;;
        [Nn]* ) 
            echo "Operation canceled by user."
            exit
            ;;
    esac
else
    echo "Creating python environment at ~/.venv"
    python3 -m venv .venv
fi

wait

echo "Bashrc Setup Complete!"
# Running system update
echo "Running a system update..."
source $HOME/.bashrc
updater
wait
echo "Installation complete! Please restart your terminal and select 'ProFont Nerd Font' in settings."



#           ---Cowsay random cow headder---
#date +"%I:%M %P | %A, %B %d, %Y" | cowsay -f dragon-and-cow
# 1. Get the list of cows
# 2. Use 'grep -v' to remove the header line
# 3. Use 'xargs' to turn the grid into a single column (removes extra spaces)
# 4. Use 'shuf' to pick one
#RANDOM_COW=$(cowsay -l | grep -v "Cow files in" | xargs -n 1 | shuf -n 1)

# Only run cowsay if RANDOM_COW is not empty to avoid errors
#if [ -n "$RANDOM_COW" ]; then
#    date +"%I:%M %P | %A, %B %d, %Y" | cowsay -f "$RANDOM_COW"
#fi
