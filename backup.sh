
#!/usr/bin/env bash

set -Eeuo pipefail

# Localiza o repositório a partir deste script.
ROOT="$(cd -- "$(dirname -- "${BASH_SOURCE[0]}")" && pwd)"

# Diretórios de configuração que queremos sincronizar.
HOME_CONFIG="$HOME/.config"

if ! command -v rsync >/dev/null 2>&1; then
    printf 'Erro: rsync não está instalado.\n' >&2
    exit 1
fi

SUCCESS=0
WARNINGS=0

log_ok() {
    printf '  [OK] %s\n' "$1"
    ((SUCCESS += 1))
}

log_warn() {
    printf '  [AVISO] %s\n' "$1" >&2
    ((WARNINGS += 1))
}

backup_dir() {
    local source="$1"
    local destination="$2"
    shift 2

    if [[ ! -d "$source" ]]; then
        log_warn "Diretório não encontrado: $source"
        return
    fi

    mkdir -p "$ROOT/$destination"

    # Não apaga arquivos extras do repositório.
    if rsync -a "$@" "$source/" "$ROOT/$destination/"; then
        log_ok "$destination"
    else
        log_warn "Falha ao sincronizar $destination"
        return 1
    fi
}

backup_file() {
    local source="$1"
    local destination="$2"

    if [[ ! -f "$source" ]]; then
        log_warn "Arquivo não encontrado: $source"
        return
    fi

    mkdir -p "$(dirname "$ROOT/$destination")"

    if cp -p -- "$source" "$ROOT/$destination"; then
        log_ok "$destination"
    else
        log_warn "Falha ao copiar $destination"
        return 1
    fi
}

backup_packages() {
    mkdir -p "$ROOT/packages"

    if command -v pacman >/dev/null 2>&1; then
        pacman -Qqe > "$ROOT/packages/pacman.txt"
        pacman -Qqem > "$ROOT/packages/aur.txt"
        log_ok "Listas de pacotes Pacman e AUR"
    else
        log_warn "Pacman não encontrado"
    fi

    if command -v flatpak >/dev/null 2>&1; then
        flatpak list --app --columns=application \
            > "$ROOT/packages/flatpaks.txt"
        log_ok "Lista de aplicativos Flatpak"
    else
        log_warn "Flatpak não instalado; lista não atualizada"
    fi
}

backup_noctalia() {
    if ! command -v noctalia >/dev/null 2>&1; then
        log_warn "Noctalia não encontrado; export ignorado"
        return
    fi

    mkdir -p "$ROOT/noctalia"

    local temp
    temp="$(mktemp "$ROOT/noctalia/.config.XXXXXX")"

    # O arquivo só é substituído se o export funcionar.
    if noctalia config export > "$temp" &&
       [[ -s "$temp" ]]; then
        mv -- "$temp" "$ROOT/noctalia/noctalia-config.toml"
        log_ok "Configuração mesclada do Noctalia"
    else
        rm -f -- "$temp"
        log_warn "Export do Noctalia falhou; arquivo anterior preservado"
        return 1
    fi
}

backup_vscode() {
    local user_config="$HOME_CONFIG/Code/User"

    # Não copia todo o perfil do VS Code: ele pode conter
    # estado, cache e outros dados que não são dotfiles.
    backup_file \
        "$user_config/settings.json" \
        "vs-code/settings.json"

    backup_file \
        "$user_config/keybindings.json" \
        "vs-code/keybindings.json"

    if [[ -d "$user_config/snippets" ]]; then
        backup_dir "$user_config/snippets" "vs-code/snippets"
    fi

    if command -v code >/dev/null 2>&1; then
        mkdir -p "$ROOT/vs-code"
        code --list-extensions > "$ROOT/vs-code/extensions.txt"
        log_ok "Extensões do VS Code"
    else
        log_warn "Comando 'code' não encontrado; extensões não atualizadas"
    fi
}

printf '\n=== Linux Dotfiles Backup ===\n\n'

# Configurações de usuário.
backup_dir "$HOME_CONFIG/fish" "fish" \
    --exclude=/fish_variables

backup_dir "$HOME_CONFIG/kitty" "kitty"
backup_dir "$HOME_CONFIG/nvim" "nvim"
backup_dir "$HOME_CONFIG/fastfetch" "fastfetch"
backup_dir "$HOME_CONFIG/niri" "niri"

# Shells e configurações individuais.
backup_file "$HOME/.zshrc" "zsh/.zshrc"
backup_file "$HOME/.gitconfig" "git/gitconfig"
backup_file "$HOME_CONFIG/starship.toml" "starship/starship.toml"

# Noctalia usa o export oficial para reunir os overrides da GUI.
backup_noctalia

# VS Code: apenas configurações selecionadas.
backup_vscode

# Inventário de software instalado.
backup_packages

printf '\n=== Resultado ===\n'
printf 'Operações concluídas: %d\n' "$SUCCESS"
printf 'Avisos: %d\n' "$WARNINGS"
printf '\nConfira as mudanças com: git -C "%s" status --short\n' "$ROOT"
printf 'Revise o diff antes de fazer commit ou push.\n'
