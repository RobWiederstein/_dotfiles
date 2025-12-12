# Define all aliases in a variable IMMEDIATELY when the file is sourced.
# This ensures they are captured before any filtering/deletion can occur.
ALL_ALIASES="$(alias)"

rkw_welcome() {
# --- RKW Welcome & Alias Helper ---

echo -e "\n========================================================"
echo -e "         🌐 Welcome to $(hostname | tr '[:lower:]' '[:upper:]') | RKW Standard CLI"
echo -e "========================================================"

# Function to get and format aliases for a specific group
print_aliases() {
    local group_regex="$1"
    local color="$2"
    local title="$3"
    local alias_list
    
    echo -e "\n\033[1;${color}m[${title}]\033[0m"

    # 1. Filter the pre-captured ALL_ALIASES variable.
    #    This is the key fix: filtering a string variable is reliable.
    alias_list=$(echo "${ALL_ALIASES}" | command grep -E "${group_regex}")

    # 2. Print the aliases in the captured list
    echo "${alias_list}" | sed 's/^alias //; s/=/\t= /' | sort

    # 3. CRITICAL: Remove (unalias) the aliases we just printed from the session
    #    This prevents them from appearing in subsequent categories.
    echo "${alias_list}" | awk '{print $2}' | sed 's/=\x27.*//' | xargs -r unalias
}

# --- 1. CALL THE ALIAS GROUPS ---

# System & Inspection
print_aliases '^(bat|cat|grep|gpu|read|search|top|alert)' '36' 'System & Inspection'

# Docker & Compose
# Targets aliases starting with d, p, or r (that are NOT navigation)
print_aliases '^(d|p|r)' '33' 'Docker & Compose'

# Navigation & Listing
# Targets aliases starting with l, ., z, or mkcd.
print_aliases '^(l|\.|z|mkcd)' '32' 'Navigation & Listing'


# --- 2. KEY HELPERS ---
echo -e "\n\033[1;35m[Key Helpers]\033[0m" # Magenta
echo -e "Ctrl+R\t\t= Fuzzy search command history (FZF)"
echo -e "vim/nvim\t= Launches Neovim (Smart Editor)"
echo -e "\n"
}
