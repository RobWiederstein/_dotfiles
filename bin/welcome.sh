#!/bin/bash
# Static MOTD for RKW CLI - Displays Key Commands

echo -e "\n========================================================"
echo -e "         🌐 Welcome to $(hostname | tr '[:lower:]' '[:upper:]') | RKW Standard CLI"
echo -e "========================================================"

echo -e "\n\033[1;36m[System & Inspection]\033[0m"
echo -e "top\t\t= Launches btop (Graphical System Monitor)"
echo -e "cat\t\t= Launches bat (Color-coded file viewer)"
echo -e "grep\t\t= Launches rg (Ripgrep: fast, ignores .git)"
echo -e "rm\t\t= SAFE DELETE (Alias for 'trash', never permanently deletes)"

echo -e "\n\033[1;31m[Safety & Recovery]\033[0m"
echo -e "tlist\t\t= Lists files currently in the trash"
echo -e "trestore\t= Interactively restores files from the trash"

echo -e "\n\033[1;34m[Git Workflow]\033[0m" # <-- NEW SECTION ADDED
echo -e "gs\t\t= Status (concise, -sb)"
echo -e "ga\t\t= Add changes"
echo -e "gcm\t\t= Commit with message"
echo -e "gl\t\t= Log (oneline, graph)"
echo -e "gd\t\t= Diff (unstaged changes)"
echo -e "gp\t\t= Push"
echo -e "gpl\t\t= Pull"

echo -e "\n\033[1;33m[Docker & Compose]\033[0m"
echo -e "dps\t\t= docker ps -a"
echo -e "dcl\t\t= docker compose logs -f"
echo -e "dcb\t\t= docker compose up -d --build"
echo -e "lab\t\t= Connects shell to JupyterLab container"

echo -e "\n\033[1;32m[Navigation & Listing]\033[0m"
echo -e "l\t\t= List files (eza: icons, Git status)"
echo -e "lt\t\t= List files in Tree View (ignores .git)"
echo -e "z [name]\t= Jumps to frequently used folders"
echo -e "mkcd [name]\t= Creates folder and enters it"

echo -e "\n\033[1;35m[Key Helpers]\033[0m"
echo -e "Ctrl+R\t\t= Fuzzy search command history (FZF)"
echo -e "vim/nvim\t= Launches Neovim (Smart Editor)"

echo -e "\n"
