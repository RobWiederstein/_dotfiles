#!/bin/bash
# RKW Dotfiles Installation Script

REPO_DIR="$HOME/_dotfiles"
MOTD_FILE="/etc/update-motd.d/99-rkw-aliases"

echo "--- 🚀 Starting RKW Gold Standard CLI Setup ---"

# --- 1. Install Necessary Binaries ---
echo -e "\n[1/4] Installing Core Utilities (apt)..."
sudo apt update
sudo apt install -y \
  neovim \
  bat \
  ripgrep \
  btop \
  eza \
  fzf \
  zoxide \
  git \
  curl \
  fd-find \
  trash-cli # <-- ADDED: The safe 'rm' replacement

# Install Starship (always separate)
echo -e "\n[2/4] Installing Starship Prompt..."
if ! command -v starship &> /dev/null; then
    curl -sS https://starship.rs/install.sh | sh
fi


# --- 2. Link Configuration Files ---
echo -e "\n[3/4] Linking Configuration Files..."

# Create the standard ~/.config/nvim path if it doesn't exist
mkdir -p "$HOME/.config/nvim"

# We assume the user's Neovim config file is placed at REPO_DIR/nvim/init.lua (or init.vim)
# This links the config file to the standard Neovim location.
NVIM_SOURCE="$REPO_DIR/nvim/init.lua"
NVIM_TARGET="$HOME/.config/nvim/init.lua"

if [ -f "$NVIM_SOURCE" ]; then
    ln -sf "$NVIM_SOURCE" "$NVIM_TARGET"
    echo "Neovim config linked successfully: $NVIM_TARGET"
else
    echo "Warning: Neovim config file not found at $NVIM_SOURCE. Skipping link."
fi


# --- 3. Update .bashrc (Non-Destructive) ---
echo -e "\n[4/4] Updating ~/.bashrc..."

# Check if the bootstrap block is already present
if ! grep -q "RKW Gold Standard Bootstrap" ~/.bashrc; then
    cat << 'EOF' >> ~/.bashrc
# --- RKW Gold Standard Bootstrap ---
# Load custom alias files from _dotfiles
for f in "$HOME/_dotfiles/aliases.d/"*.sh; do [ -r "$f" ] && source "$f"; done

# Initialize FZF/Zoxide/Starship
# Note: Ubuntu/Debian places FZF init scripts here.
[ -r /usr/share/doc/fzf/examples/key-bindings.bash ] && source /usr/share/doc/fzf/examples/key-bindings.bash
[ -r /usr/share/doc/fzf/examples/completion.bash ] && source /usr/share/doc/fzf/examples/completion.bash

# Init Zoxide and Alias vim=nvim
command -v zoxide >/dev/null 2>&1 && eval "$(zoxide init bash)"
command -v nvim >/dev/null 2>&1 && alias vim=nvim

# Init Starship (must be last to ensure prompt displays correctly)
command -v starship >/dev/null 2>&1 && eval "$(starship init bash)"
# --- End RKW Bootstrap ---
EOF
    echo "Bootstrap block added to ~/.bashrc."
else
    echo "Bootstrap already exists in .bashrc. Skipping."
fi

# --- 4. Install MOTD (Welcome Screen) ---
echo -e "\n[5/5] Installing MOTD Alias Display..." # <-- FIXED STEP NUMBERING

# Note: We assume the 99-rkw-aliases script is also in your repo now.
MOTD_SOURCE="$REPO_DIR/bin/welcome.sh" # Assumed location from your 'lt' output

if [ -f "$MOTD_SOURCE" ]; then
    sudo cp "$MOTD_SOURCE" "$MOTD_FILE"
    sudo chmod +x "$MOTD_FILE"
    echo "MOTD script copied and made executable."
else
    echo "Warning: MOTD script not found at $MOTD_SOURCE. Skipping."
fi

echo -e "\n✅ Setup Complete! Please run 'source ~/.bashrc' or reconnect."
