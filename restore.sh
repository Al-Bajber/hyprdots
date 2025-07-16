#!/bin/bash

set -e

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
  qt5ct
  qt6ct
  starship.toml
)

echo "📦 Installing essential packages..."

# Install paru if not found
if ! command -v paru &>/dev/null; then
  echo "⚙️ Installing paru (AUR helper)..."
  sudo pacman -S --needed --noconfirm git base-devel
  git clone https://aur.archlinux.org/paru.git ~/paru
  (cd ~/paru && makepkg -si --noconfirm)
  rm -rf ~/paru
fi

# Official packages
sudo pacman -S --needed --noconfirm \
  hyprland kitty rofi waybar dunst starship neovim \
  qt5ct qt6ct mpv btop zsh neofetch noto-fonts \
  ttf-fira-code ttf-liberation gnu-free-fonts cantarell-fonts unzip wl-clipboard

# AUR packages via paru (fonts and Hyprland extras)
paru -S --needed --noconfirm \
  hyprpaper hyprlock swww \
  ttf-font-awesome-git ttf-material-icons ttf-cascadia-code-nerd \
  ttf-ubuntu-font-family ttf-amiri ttf-scheherazade \
  ttf-hack-nerd noto-fonts-emoji

echo "✅ Packages and fonts installed."

echo "🔗 Restoring symlinks into $CONFIG_DIR"
mkdir -p "$CONFIG_DIR"

for name in "${CONFIGS[@]}"; do
  src="$DOTFILES_DIR/$name"
  dest="$CONFIG_DIR/$name"

  if [ ! -e "$src" ]; then
    echo "❌ Skipping $name — not found in $DOTFILES_DIR"
    continue
  fi

  if [ -e "$dest" ] && [ ! -L "$dest" ]; then
    echo "🗂  Backing up existing $dest to $dest.backup"
    mv "$dest" "$dest.backup"
  fi

  echo "🔗 Linking $dest → $src"
  ln -sf "$src" "$dest"
done

# Refresh font cache
echo "🔁 Rebuilding font cache..."
fc-cache -fv

# Optional shell switch to zsh
if [ "$SHELL" != "/bin/zsh" ]; then
  echo "💡 Changing default shell to zsh"
  chsh -s /bin/zsh
fi

echo "🎉 Full restore complete. You can now reboot into your Hyprland DE!"

