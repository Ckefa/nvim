#!/usr/bin/bash

sudo apt install\
	tmux\
	net-tools \
	git gcc \
	ripgrep \
	zoxide \
	python3-venv\

# Ensure the script is being run with root privileges
if [ "$(id -u)" -ne 0 ]; then
    echo "Please run as root"
    exit 1
fi

# Update and install required packages
echo "Updating packages and installing dependencies..."
apt update && apt install -y zsh git curl

# Install Oh My Zsh (for managing plugins)
echo "Installing Oh My Zsh..."
sh -c "$(curl -fsSL https://raw.githubusercontent.com/ohmyzsh/ohmyzsh/master/tools/install.sh)"

# Set Zsh as the default shell
echo "Setting Zsh as the default shell for $(whoami)..."
chsh -s $(which zsh) $(whoami)

# Define plugin paths
ZSH_CUSTOM="$HOME/.oh-my-zsh/custom"
SYNTAX_HIGHLIGHTING="$ZSH_CUSTOM/plugins/zsh-syntax-highlighting"
AUTOSUGGESTIONS="$ZSH_CUSTOM/plugins/zsh-autosuggestions"
SUBSTRING_SEARCH="$ZSH_CUSTOM/plugins/zsh-history-substring-search"

# Install Zsh Syntax Highlighting
if [ ! -d "$SYNTAX_HIGHLIGHTING" ]; then
    echo "Installing Zsh Syntax Highlighting..."
    git clone https://github.com/zsh-users/zsh-syntax-highlighting.git $SYNTAX_HIGHLIGHTING
else
    echo "Zsh Syntax Highlighting already installed."
fi

# Install Zsh Autosuggestions
if [ ! -d "$AUTOSUGGESTIONS" ]; then
    echo "Installing Zsh Autosuggestions..."
    git clone https://github.com/zsh-users/zsh-autosuggestions.git $AUTOSUGGESTIONS
else
    echo "Zsh Autosuggestions already installed."
fi

# Install Zsh History Substring Search
if [ ! -d "$SUBSTRING_SEARCH" ]; then
    echo "Installing Zsh History Substring Search..."
    git clone https://github.com/zsh-users/zsh-history-substring-search.git $SUBSTRING_SEARCH
else
    echo "Zsh History Substring Search already installed."
fi

# Enable plugins in .zshrc
echo "Configuring plugins in .zshrc..."
sed -i 's/^plugins=(/plugins=(zsh-syntax-highlighting zsh-autosuggestions zsh-history-substring-search /' ~/.zshrc

# Apply changes
echo "Reloading .zshrc to apply changes..."

echo "Zsh installation and configuration complete!"


# Ensure the script is being run with root privileges
if [ "$(id -u)" -ne 0 ]; then
    echo "Please run as root"
    exit 1
fi

# Install Starship if it's not already installed
if ! command -v starship &> /dev/null; then
    echo "Installing Starship..."
    curl -sS https://starship.rs/install.sh | sh
else
    echo "Starship is already installed."
fi

# Configure Starship using the provided starship.toml file
echo "Configuring Starship..."
if [ -f "starship.toml" ]; then
    # Move or copy the starship.toml file to the appropriate directory
    mkdir -p ~/.config
    cp starship.toml ~/.config/starship.toml
    echo "Starship configuration applied from starship.toml"
else
    echo "starship.toml file not found in the current directory."
fi

source ~/.zshrc

# Instructions for adding Starship to the shell profile
echo "Add the following line to your shell's profile file (e.g., ~/.zshrc, ~/.bashrc):"
echo 'eval "$(starship init zsh)"'  # Replace 'zsh' with 'bash' if using Bash
echo "Starship installation and configuration complete!"

echo "================All Tools installed Success===============";

