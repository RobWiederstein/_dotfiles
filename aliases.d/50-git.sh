# ----------------------------------------------------
# 50-git.sh - Core Git Aliases
# ----------------------------------------------------

# If git is not installed, exit the script early.
command -v git >/dev/null 2>&1 || return

# Status and History
alias gs='git status -sb'
alias gl='git log --oneline --decorate --graph'
alias gd='git diff'

# Staging and Committing
alias ga='git add'
alias gcm='git commit -m'

# Push and Pull
alias gp='git push'
alias gpl='git pull'
