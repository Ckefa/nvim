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

# Step 5: Install Oh My Zsh and Powerlevel10k theme
echo "Installing Oh My Zsh..."
if [[ ! -d ~/.oh-my-zsh ]]; then
    sh -c "$(curl -fsSL https://raw.githubusercontent.com/ohmyzsh/ohmyzsh/master/tools/install.sh)" "" --unattended
else
    echo "Oh My Zsh is already installed. Skipping installation."
fi

# Clone Powerlevel10k if not already installed
if [[ ! -d ~/.oh-my-zsh/custom/themes/powerlevel10k ]]; then
    echo "Installing Powerlevel10k theme..."
    git clone --depth=1 https://github.com/romkatv/powerlevel10k.git ~/.oh-my-zsh/custom/themes/powerlevel10k
else
    echo "Powerlevel10k theme is already installed. Skipping."
fi

# Step 6: Install Zsh Syntax Highlighting
if [[ ! -d ~/.oh-my-zsh/custom/plugins/zsh-syntax-highlighting ]]; then
    echo "Installing Zsh Syntax Highlighting..."
    git clone https://github.com/zsh-users/zsh-syntax-highlighting.git ~/.oh-my-zsh/custom/plugins/zsh-syntax-highlighting
else
    echo "Zsh Syntax Highlighting is already installed. Skipping."
fi

# Step 7: Install Zsh Auto-suggestions
if [[ ! -d ~/.oh-my-zsh/custom/plugins/zsh-autosuggestions ]]; then
    echo "Installing Zsh Auto-suggestions..."
    git clone https://github.com/zsh-users/zsh-autosuggestions ~/.oh-my-zsh/custom/plugins/zsh-autosuggestions
else
    echo "Zsh Auto-suggestions is already installed. Skipping."
fi

# Step 8: Modify the .zshrc file
echo "Configuring .zshrc..."
ZSHRC_FILE=~/.zshrc
if ! grep -q "ZSH_THEME=\"powerlevel10k/powerlevel10k\"" "$ZSHRC_FILE"; then
    echo 'ZSH_THEME="powerlevel10k/powerlevel10k"' >> "$ZSHRC_FILE"
fi
if ! grep -q "plugins=(git zsh-autosuggestions zsh-syntax-highlighting)" "$ZSHRC_FILE"; then
    echo 'plugins=(git zsh-autosuggestions zsh-syntax-highlighting)' >> "$ZSHRC_FILE"
fi

# Step 9: Finish and Notify
echo "Installation complete! Please restart your terminal to apply the changes."
