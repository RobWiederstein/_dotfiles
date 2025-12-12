# ---- navigation
alias ..='cd ..'; alias ...='cd ../..'; alias ....='cd ../../..'; alias .....='cd ../../../..'
alias cd..='cd .. && l'; alias cd...='cd ../.. && l'
# if an md alias exists from older files, remove it so our function takes over
unalias md 2>/dev/null
md() { mkdir -p -- "$1" && cd -- "$1"; }
alias mkcd='mkdir -pv'

# ---- fzf helpers (only if fzf is installed)
cdf() { command -v fzf >/dev/null || { echo "install fzf for cdf" >&2; return 1; }; cd "$(find . -type d -print | fzf)" || return; }
cdh() { mapfile -t d < <(dirs -v | awk '{print $2}'); for i in "${!d[@]}"; do printf "[%d] %s\n" "$i" "${d[$i]}"; done; read -rp "Select: " n; cd -- "${d[$n]}" || return; }

# ---- eza (fallback to ls if eza isn’t found)
if command -v eza >/dev/null 2>&1; then
  alias l='eza --long --header --binary --all --icons --git --group-directories-first --time-style=long-iso'
  alias l1='l --tree --level=1 --total-size'; alias l2='l --tree --level=2 --total-size'
  alias l3='l --tree --level=3 --total-size'; alias l4='l --tree --level=4 --total-size'
  alias lt='l --tree --total-size'
  alias lg='eza --long --header --binary --all --icons --git --group-directories-first --time-style=long-iso --git-ignore'
  alias lc='eza --all --icons --git --group-directories-first'
  alias lsd='eza --long --header --all --icons --group-directories-first --dirs-only'
  alias tree='eza -T'
else
  alias l='ls -lah --group-directories-first'; alias lt='ls -lahR --group-directories-first'
fi
