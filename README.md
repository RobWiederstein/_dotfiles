# 🌟 RKW Gold Standard CLI & Dotfiles

This repository contains the standardized, modern command-line interface (CLI) and configuration for my Ubuntu/Debian virtual machines (Analytics, Immich, etc.).

It features the "Rust Rewrite" tools (eza, bat, ripgrep) and an automated setup script for fast, reproducible deployment.

---

## 🚀 One-Command Setup (New VMs)

To set up a new Ubuntu/Debian VM with the exact same CLI tools, aliases, and configuration (including Neovim, Starship, and the Welcome Message):

### Prerequisites
1.  **SSH Access:** Ensure you can SSH into the new VM as the `rkw` user.
2.  **Git Installed:** `sudo apt install git` (If not already present).

### Installation
Execute these two commands from the new VM's home directory (`~`):

```bash
# 1. Clone the repository
git clone [https://github.com/RobWiederstein/_dotfiles.git](https://github.com/RobWiederstein/_dotfiles.git) ~/_dotfiles

# 2. Run the automated setup script (Installs tools, configures ~/.bashrc, sets up MOTD)
~/_dotfiles/setup.sh
```
After the script completes, run source ~/.bashrc or log out and log back in.
