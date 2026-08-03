#!/usr/bin/env bash

set -e

ROOT="/home/victor/Documentos/linux-dotfiles"

echo "Backup do Fish..."
cp -r ~/.config/fish/* "$ROOT/fish/"

echo "Backup do Kitty..."
cp -r ~/.config/kitty/* "$ROOT/kitty/"

echo "Backup do Nvim..."
cp -r ~/.config/nvim/* "$ROOT/nvim/"

echo "Backup do Fastfetch..."
cp -r ~/.config/fastfetch/* "$ROOT/fastfetch/"

echo "Backup do Starship..."
cp ~/.config/starship.toml "$ROOT/starship/"

echo "Backup do Git..."
cp ~/.gitconfig "$ROOT/git/gitconfig"

echo "Backup concluído!"