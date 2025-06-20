#!/bin/bash
# Simple bootstrap for dotfiles

set -e

echo "🚀 Setting up dotfiles..."

# Install Homebrew if not present
if ! command -v brew >/dev/null 2>&1; then
  echo "📦 Installing Homebrew..."
  /bin/bash -c "$(curl -fsSL https://raw.githubusercontent.com/Homebrew/install/HEAD/install.sh)"
  eval "$(/opt/homebrew/bin/brew shellenv)"
fi

# Clone dotfiles
DOTFILES_DIR="$HOME/.dotfiles"
if [ ! -d "$DOTFILES_DIR" ]; then
  echo "📥 Cloning dotfiles..."
  git clone https://github.com/orionreed/dotfiles.git "$DOTFILES_DIR"
else
  echo "📁 Updating dotfiles..."
  cd "$DOTFILES_DIR" && git pull
fi

# Run dotbot
echo "⚙️ Installing..."
cd "$DOTFILES_DIR"
eval "$(/opt/homebrew/bin/brew shellenv)"
dotbot -c install.conf.yaml

echo "✅ Done!"
