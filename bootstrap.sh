#!/bin/bash
# Simple bootstrap for dotfiles

set -e

echo "🚀 Setting up dotfiles..."

# Clone dotfiles
DOTFILES_DIR="$HOME/.dotfiles"
if [ ! -d "$DOTFILES_DIR" ]; then
  echo "📥 Cloning dotfiles..."
  git clone --recurse-submodules https://github.com/orionreed/dotfiles.git "$DOTFILES_DIR"
else
  echo "📁 Updating dotfiles..."
  cd "$DOTFILES_DIR" && git pull && git submodule update --init --recursive
fi

# Run dotbot
echo "⚙️ Installing..."
cd "$DOTFILES_DIR"
git -C "dotbot" submodule sync --quiet --recursive
git submodule update --init --recursive "dotbot"
"./dotbot/bin/dotbot" -d "$(pwd)" -c "install.conf.yaml"

echo "✅ Done!"
