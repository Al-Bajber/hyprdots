#!/bin/bash

DOTFILES_DIR=~/Desktop/Projects/hyprdots
CONFIG_DIR=~/.config

CONFIGS=(
  dunst
  fontconfig
  hypr
  kitty
  mpv
  neofetch
  nvim
  rofi
  waybar
  yazi
  gtk-2.0
  gtk-3.0
  gtk-4.0
  starship.toml
)

echo "🔗 Restoring symlinks into $CONFIG_DIR"

for name in "${CONFIGS[@]}"; do
  src="$DOTFILES_DIR/$name"
  dest="$CONFIG_DIR/$name"

  # Skip if source doesn't exist
  if [ ! -e "$src" ]; then
    echo "❌ Skipping $name — not found in $DOTFILES_DIR"
    continue
  fi

  # Backup if something already exists
  if [ -e "$dest" ] && [ ! -L "$dest" ]; then
    echo "🗂  Backing up existing $dest to $dest.backup"
    mv "$dest" "$dest.backup"
  fi

  echo "🔗 Linking $dest → $src"
  ln -sf "$src" "$dest"
done

echo "✅ All symlinks restored."

