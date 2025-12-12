# Define all aliases in a variable IMMEDIATELY when the file is sourced.
# This ensures they are captured before any filtering/deletion can occur.
ALL_ALIASES="$(alias)"

rkw_welcome() {
# --- RKW Welcome & Alias Helper ---

echo -e "\n========================================================"
echo -e "         🌐 Welcome to $(hostname | tr '[:lower:]' '[:upper:]') | RKW Standard CLI"
echo -e "========================================================"

# Function to get and format aliases for a specific group
print_aliases() {
    local group_regex="$1"
    local color="$2"
    local title="$3"
    local alias_list
    
    echo -e "\n\033[1;${color}m[${title}]\033[0m"

    # 1. Filter the pre-captured ALL_ALIASES variable.
    #    This is the key fix: filtering a string variable is reliable.
    alias_list=$(echo "${ALL_ALIASES}" | command grep -E "${group_regex}")

    # 2. Print the aliases in the captured list
    echo "${alias_list}" | sed 's/^alias //; s/=/\t= /' | sort

    # 3. CRITICAL: Remove (unalias) the aliases we just printed from the session
    #    This prevents them from appearing in subsequent categories.
    echo "${alias_list}" | awk '{print $2}' | sed 's/=\x27.*//' | xargs -r unalias
}

# --- 1. CALL THE ALIAS GROUPS (Order matters for cleanup) ---

# System & Inspection (Includes basic inspection tools)
print_aliases '^(bat|cat|grep|gpu|read|search|top|alert)' '36' 'System & Inspection'

# Safety & Deletion (NEW CATEGORY: Handles rm, trash list, restore, and empty)
# Requires alias names: rm, rmdir, tlist, tempty, trestore
# Note: rm/rmdir are often captured by print_aliases '^(r.*)', so we must explicitly filter for them.
print_aliases '^(rm|rmdir|tlist|tempty|trestore)' '31' 'Safety & Deletion' # Red/Bright Red

# Docker & Compose
# Targets aliases starting with d (followed by a non-dot), p, or r (that are not rm/rmdir)
# Adjusted to avoid conflicting with Navigation (which often has dots like '...')
print_aliases '^(d[^.]|p|r)' '33' 'Docker & Compose' # Yellow

# Navigation & Listing
# Targets aliases starting with l, cd..., ., z, or mkcd.
print_aliases '^(l|cd|md|mkcd|z)' '32' 'Navigation & Listing' # Green


# --- 2. CONFIGURATION & KEY HELPERS ---
echo -e "\n\033[1;35m[Configuration & Key Helpers]\033[0m" # Magenta
echo -e "\n\033[1;37m[Config Files & Purpose]\033[0m" # White/Light Gray
echo -e "~/.bashrc\t= The Primary Loader (Sources all aliases and initializes Starship)"
echo -e "~/.config/nvim/\t= Neovim Configuration (Sets line numbers, mouse, colors)"
echo -e "~/_dotfiles/\t= Directory for all custom aliases and utility scripts"
echo -e "/etc/update-motd.d/\t= MOTD Scripts (This screen is generated here)"

echo -e "\n\033[1;37m[Key Helpers]\033[0m" # White/Light Gray
echo -e "Ctrl+R\t\t= Fuzzy search command history (FZF)"
echo -e "vim/nvim\t= Launches Neovim (Smart Editor)"

echo -e "\n"
}
