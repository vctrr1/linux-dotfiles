# Inicialização do Starship
starship init fish | source

# Inicialização do FNM
fnm env --use-on-cd | source

# pnpm
set -gx PNPM_HOME "/home/victor/.local/share/pnpm"
if not string match -q -- $PNPM_HOME $PATH
  set -gx PATH "$PNPM_HOME" $PATH
end
# pnpm end
