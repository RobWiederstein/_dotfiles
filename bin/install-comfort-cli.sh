#!/usr/bin/env bash
set -euo pipefail

PKGS=(
  ripgrep fd-find bat fzf zoxide jq yq neovim tmux rclone htop btop ncdu
  iperf3 mtr-tiny nmap tree
  git curl wget unzip zip build-essential ca-certificates pkg-config
  bash-completion net-tools iproute2 iputils-ping dnsutils
)

echo "→ Updating package lists"
sudo apt update -y

# collect only missing packages (init the array first)
MISS=()
for p in "${PKGS[@]}"; do
  dpkg -s "$p" &>/dev/null || MISS+=("$p")
done

if ((${#MISS[@]})); then
  echo "→ Installing: ${MISS[*]}"
  sudo apt install -y "${MISS[@]}"
else
  echo "✓ All comfort packages already present"
fi

# keep your custom /usr/local/bin/eza; install apt eza only if it's not present at all
if ! command -v eza >/dev/null 2>&1; then
  sudo apt install -y eza || true
fi

# map Debian names to common commands
if command -v batcat >/dev/null 2>&1; then
  sudo update-alternatives --install /usr/local/bin/bat bat /usr/bin/batcat 10
fi
if command -v fdfind >/dev/null 2>&1; then
  sudo update-alternatives --install /usr/local/bin/fd fd /usr/bin/fdfind 10
fi

# --- Bash bootstrap (idempotent) ---
if ! grep -q '_dotfiles bootstrap' ~/.bashrc; then
  cat >> ~/.bashrc <<'RC'

# --- _dotfiles bootstrap ---
[ -f "$HOME/.bash_aliases" ] && source "$HOME/.bash_aliases"
for f in "$HOME/_dotfiles/aliases.d/"*.sh; do [ -r "$f" ] && source "$f"; done
[ -r /usr/share/doc/fzf/examples/key-bindings.bash ] && source /usr/share/doc/fzf/examples/key-bindings.bash
[ -r /usr/share/doc/fzf/examples/completion.bash ] && source /usr/share/doc/fzf/examples/completion.bash
command -v zoxide >/dev/null 2>&1 && eval "$(zoxide init bash)"
command -v nvim   >/dev/null 2>&1 && alias vim=nvim
RC
fi

echo "✓ Install finished."
