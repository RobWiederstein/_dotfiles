#!/usr/bin/env bash
set -euo pipefail

printf "%-12s %-11s %-40s %s\n" "TOOL" "STATUS" "LOCATION" "SOURCE"

tools=(
  "eza:eza"
  "rg:ripgrep"
  "fd|fdfind:fd-find"
  "bat|batcat:bat"
  "fzf:fzf"
  "zoxide:zoxide"
  "jq:jq"
  "yq:yq"
  "nvim:neovim"
  "tmux:tmux"
  "rsync:rsync"
  "rclone:rclone"
  "htop:htop"
  "btop:btop"
  "ncdu:ncdu"
  "iperf3:iperf3"
  "mtr:mtr-tiny"
  "nmap:nmap"
  "tree:tree"
)

for entry in "${tools[@]}"; do
  IFS=':' read -r cmdlist pkg <<<"$entry"
  IFS='|' read -r -a cmds <<<"$cmdlist"

  found_cmd=""
  for c in "${cmds[@]}"; do
    if command -v "$c" >/dev/null 2>&1; then
      found_cmd="$c"
      break
    fi
  done

  if [[ -n "$found_cmd" ]]; then
    loc="$(command -v "$found_cmd")"
    if dpkg -s "$pkg" >/dev/null 2>&1; then
      printf "%-12s %-11s %-40s %s\n" "$found_cmd" "✅ present" "$loc" "APT package: $pkg"
    else
      printf "%-12s %-11s %-40s %s\n" "$found_cmd" "✅ present" "$loc" "non-APT (custom/cargo/binary?)"
    fi
  else
    if dpkg -s "$pkg" >/dev/null 2>&1; then
      printf "%-12s %-11s %-40s %s\n" "${cmds[0]}" "⚠︎ installed" "-" "APT says '$pkg' installed, but not on PATH"
    else
      printf "%-12s %-11s %-40s %s\n" "${cmds[0]}" "❌ missing" "-" "not found"
    fi
  fi
done
