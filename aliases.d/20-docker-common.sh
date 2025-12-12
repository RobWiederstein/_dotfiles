# --- Docker & Docker Compose General Aliases ---

# General Docker shortcuts (replaces 'docker' with 'd')
alias d='docker'
alias dps='docker ps -a'
alias dimg='docker images'
alias dstart='docker start'
alias dstop='docker stop'
alias drm='docker rm'

# Aggressive cleanup of containers/images (use with caution)
alias dstall='docker stop $(docker ps -a -q)'
alias drmall='docker rm $(docker ps -a -q)'
alias dprune='docker system prune -a --volumes'


# Docker Compose shortcuts (replaces 'docker compose' with 'dc')
alias dc='docker compose'
alias dcup='docker compose up -d'
alias dcd='docker compose down'
alias dcr='docker compose restart'
alias dcl='docker compose logs -f'
alias dcb='docker compose up -d --build'
