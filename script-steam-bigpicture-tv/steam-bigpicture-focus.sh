#!/usr/bin/env bash

# Procura a janela do Steam Big Picture
find_bigpicture() {
    niri msg --json windows |
        jq -r '.[] | select(
            .app_id == "steam" and
            .title == "Steam — Modo Big Picture"
        ) | .id' |
        head -n1
}

# Verifica se o Big Picture já está aberto
window_id=$(find_bigpicture)

# Se não estiver aberto, solicita sua abertura
if [[ -z "$window_id" ]]; then
    steam steam://open/bigpicture

    # Aguarda a janela aparecer
    for _ in {1..30}; do
        sleep 0.2
        window_id=$(find_bigpicture)
        [[ -n "$window_id" ]] && break
    done
fi

# Foca a janela e troca para sua workspace
if [[ -n "$window_id" ]]; then
    niri msg action focus-window --id "$window_id"
    niri msg action focus-monitor HDMI-A-1
fi
