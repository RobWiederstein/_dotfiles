#!/bin/bash
# RKW Dotfiles Installation Script

REPO_DIR="$HOME/_dotfiles"
MOTD_FILE="/etc/update-motd.d/99-rkw-aliases"

echo "--- 🚀 Starting RKW Gold Standard CLI Setup ---"

# --- 1. Install Necessary Binaries ---
echo -e "\n[1/4] Installing Core Utilities (apt)..."
sudo apt update
sudo apt install -y neovim bat ripgrep btop eza fzf zoxide git curl

# Install Starship (always separate)
echo -e "\n[2/4] Installing Starship Prompt..."
curl -sS https://starship.rs/install.sh | sh

# --- 2. Link Configuration Files ---
echo -e "\n[3/4] Linking Configuration Files..."

# Link the nvim config from the repo location to ~/.config/
mkdir -p ~/.config
ln -sf $REPO_DIR/config/nvim ~/.config/nvim 

# Note: You would place your init.vim inside a folder like ~/ _dotfiles/config/nvim/

# --- 3. Update .bashrc (Non-Destructive) ---
echo -e "\n[4/4] Updating ~/.bashrc..."

# Check if the bootstrap block is already present
if ! grep -q "RKW Gold Standard Bootstrap" ~/.bashrc; then
    cat << 'EOF' >> ~/.bashrc
# --- RKW Gold Standard Bootstrap ---
# Load custom alias files from _dotfiles
for f in "$HOME/_dotfiles/aliases.d/"*.sh; do [ -r "$f" ] && source "$f"; done

# Initialize FZF/Zoxide/Starship
[ -r /usr/share/doc/fzf/examples/key-bindings.bash ] && source /usr/share/doc/fzf/examples/key-bindings.bash
[ -r /usr/share/doc/fzf/examples/completion.bash ] && source /usr/share/doc/fzf/examples/completion.bash
command -v zoxide >/dev/null 2>&1 && eval "$(zoxide init bash)"
command -v nvim   >/dev/null 2>&1 && alias vim=nvim
eval "$(starship init bash)"
# --- End RKW Bootstrap ---
EOF
else
    echo "Bootstrap already exists in .bashrc. Skipping."
fi

# --- 4. Install MOTD (Welcome Screen) ---
echo -e "\n[5/4] Installing MOTD Alias Display..."

# Note: We assume the 99-rkw-aliases script is also in your repo now.
if [ -f $REPO_DIR/99-rkw-aliases ]; then
    sudo cp $REPO_DIR/99-rkw-aliases $MOTD_FILE
    sudo chmod +x $MOTD_FILE
    echo "MOTD script copied and made executable."
fi

echo -e "\n✅ Setup Complete! Please run 'source ~/.bashrc' or reconnect."
