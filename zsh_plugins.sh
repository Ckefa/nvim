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

if [[ ! -d "$ZSH_CUSTOM/plugins/zsh-history-substring-search" ]]; then
    echo "Installing Zsh History Substring Search..."
    git clone https://github.com/zsh-users/zsh-history-substring-search.git "$ZSH_CUSTOM/plugins/zsh-history-substring-search"
else
    echo "Zsh History Substring Search is already installed. Skipping."
fi
