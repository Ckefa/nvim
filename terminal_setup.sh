#!/bin/bash

# Ensure script is run with superuser privileges
if [[ $EUID -ne 0 ]]; then
    echo "This script must be run as root"
    exit 1
fi

# Step 1: Update the system
echo "Updating the system..."
pacman -Syu --noconfirm

# Step 2: Install Zsh
echo "Installing Zsh..."
pacman -S zsh --noconfirm

# Step 3: Make Zsh the default shell
echo "Setting Zsh as the default shell..."
if [[ "$(echo $SHELL)" != "$(which zsh)" ]]; then
    chsh -s "$(which zsh)"
else
    echo "Zsh is already the default shell."
fi

# Step 4: Install Git
echo "Installing Git..."
pacman -S git --noconfirm

# Step 8: Modify the .zshrc file
echo "Configuring .zshrc..."
ZSHRC_FILE=~/.zshrc
if ! grep -q "ZSH_THEME=\"powerlevel10k/powerlevel10k\"" "$ZSHRC_FILE"; then
    echo 'ZSH_THEME="powerlevel10k/powerlevel10k"' >> "$ZSHRC_FILE"
fi
if ! grep -q "plugins=(git zsh-autosuggestions zsh-syntax-highlighting)" "$ZSHRC_FILE"; then
    echo 'plugins=(git zsh-autosuggestions zsh-syntax-highlighting)' >> "$ZSHRC_FILE"
fi

# Step 9: Copy and source config files
echo "Copying config files to $HOME"
cp -r $HOME/.config/nvim/{.zshrc,.tmux.conf} $HOME
echo "Sourcing zshrc"
source $HOME/.zshrc
echo "Sourcing $HOME/.tmux.conf"
tmux source $HOME/.tmux.conf

# Step 10: Finish and Notify
echo "Installation complete! Please restart your terminal to apply the changes."
