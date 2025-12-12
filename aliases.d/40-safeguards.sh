# ---- 40-safeguards.sh (Trash/Delete Aliases)
# Replaces 'rm' with 'trash' for safety, and defines easy recovery aliases.

# Check for the primary 'trash' binary for safe deletion
if command -v trash &> /dev/null; then
    alias rm='trash'
    alias rmdir='trash'
fi

# Check for the secondary utilities needed for listing/restoring
if command -v trash-list &> /dev/null; then
    alias tlist='trash-list'
    alias trestore='restore-trash'
    alias tempty='trash-empty'
fi
