#!/bin/bash

# Step 1: Update the system
echo "Updating the system..."
sudo yay -Syyu --noconfirm

echo "Installing apps"
./apps_install.sh;

echo "Setting up Zsh"
./zsh_plugins.sh;

echo "Installing fonts"
yay -S ttf-hack-nerd noto-fonts-emoji ttf-nerd-fonts-symbols --noconfirm;

# Step 3: Make Zsh the default shell
echo "Setting Zsh as the default shell..."
if [[ "$(echo $SHELL)" != "$(which zsh)" ]]; then
    chsh -s "$(which zsh)"
else
    echo "Zsh is already the default shell."
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

# Step 9: Copy and source config files
echo "Copying config files to $HOME"
cp -r $HOME/.config/nvim/{.zshrc,.tmux.conf} $HOME
echo "Copying config waybar Config"
cp -r $HOME/.config/nvim/waybar/ $HOME/.config
echo "Copying config sway Config"
sudo cp $HOME/.config/nvim/sway.config /etc/sway/config
echo "Sourcing zshrc"
source $HOME/.zshrc
echo "Sourcing $HOME/.tmux.conf"
tmux source $HOME/.tmux.conf

# Step 10: Finish and Notify
echo "Installation complete! Please restart your terminal to apply the changes."
