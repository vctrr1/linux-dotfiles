# ==========================================
# Zsh
# ==========================================

# Autocompletion
autoload -Uz compinit
compinit

# ==========================================
# Autosuggestions
# ==========================================

source /usr/share/zsh/plugins/zsh-autosuggestions/zsh-autosuggestions.zsh

# ==========================================
# Syntax Highlighting
# ==========================================

source /usr/share/zsh/plugins/zsh-syntax-highlighting/zsh-syntax-highlighting.zsh

# ==========================================
# Starship
# ==========================================

# StarShip
eval "$(starship init zsh)"

# Fast Node Manager
eval "$(fnm env --use-on-cd)"

export TERMINAL=kitty


