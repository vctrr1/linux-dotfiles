#!/usr/bin/env bash

# Procura a janela do Steam Big Picture
find_bigpicture() {
    umbriel windows --json |
        jq -r '.[] | select(
            .app_id == "steam" and
            .title == "Steam — Modo Big Picture"
        ) | .id' |
        head -n1
}

window_id=$(find_bigpicture)

if [[ -z "$window_id" ]]; then
    # Primeiro clique: abre o Big Picture
    steam steam://open/bigpicture
else
    # Segundo clique: foca o Big Picture e move o cursor
    umbriel msg window-focus-warp "$window_id"
fi
