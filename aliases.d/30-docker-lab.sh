# --- RKW Analytics Lab Aliases ---

# RStudio Server Shortcuts
alias rcomp='docker compose -f ~/docker/rstudio/compose.yml'
alias rps='rcomp ps'
alias rlogs='rcomp logs -f'

# Jupyter Lab (Python/GPU) Shortcuts
alias pcomp='docker compose -f ~/docker/python-gpu/compose.yml'
alias pps='pcomp ps'
alias lab='pcomp exec -T lab bash'

# GPU Monitoring
alias gpu='watch -n 0.5 nvidia-smi'
