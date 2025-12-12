# --- Modern CLI Tools ---

# 1. Bat (Better Cat)
# Ubuntu installs it as 'batcat' to avoid conflict. We alias it back.
if command -v batcat >/dev/null 2>&1; then
  alias cat='batcat --style=plain --paging=never'
  alias read='batcat --style=header,grid,numbers'
  alias bat='batcat'
fi

# 2. Ripgrep (Better Grep)
# 'rg' is the binary name.
if command -v rg >/dev/null 2>&1; then
  alias grep='rg'
  alias search='rg --files | fzf --preview "batcat --style=numbers --color=always {}"'
fi

# 3. Btop (Better Top)
alias top='btop'
