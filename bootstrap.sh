#!/bin/bash
# Simple bootstrap for dotfiles

set -e

echo "🚀 Setting up dotfiles..."

# Install Homebrew if not present
if ! command -v brew >/dev/null 2>&1; then
  echo "📦 Installing Homebrew..."
  /bin/bash -c "$(curl -fsSL https://raw.githubusercontent.com/Homebrew/install/HEAD/install.sh)"

  # Ensure Homebrew is properly sourced in the current shell
  echo 'eval "$(/opt/homebrew/bin/brew shellenv)"' >>~/.zprofile
  eval "$(/opt/homebrew/bin/brew shellenv)"
fi

# Double-check Homebrew is available
export PATH="/opt/homebrew/bin:$PATH"

# Install dotbot
echo "📦 Installing dotbot..."
/opt/homebrew/bin/brew install dotbot

# Clone dotfiles
DOTFILES_DIR="$HOME/.dotfiles"
if [ ! -d "$DOTFILES_DIR" ]; then
  echo "📥 Cloning dotfiles..."
  git clone https://github.com/orionreed/dotfiles.git "$DOTFILES_DIR"
else
  echo "📁 Updating dotfiles..."
  cd "$DOTFILES_DIR" && git pull
fi

# Install packages from Brewfile
echo "📦 Installing packages..."
cd "$DOTFILES_DIR"
/opt/homebrew/bin/brew bundle --file=Brewfile

# Run dotbot for configuration
echo "⚙️ Configuring..."
/opt/homebrew/bin/dotbot -c install.conf.yaml

echo "✅ Done!"
