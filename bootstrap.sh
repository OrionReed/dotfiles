#!/bin/bash
# Minimal bootstrap script for fresh macOS
# Only installs essential tools, then lets Dotbot do everything else

set -e

echo "🚀 Bootstrapping development environment..."

# Install Homebrew if not present (needed for git and everything else)
if ! command -v brew >/dev/null 2>&1; then
  echo "📦 Installing Homebrew..."
  /bin/bash -c "$(curl -fsSL https://raw.githubusercontent.com/Homebrew/install/HEAD/install.sh)"
  eval "$(/opt/homebrew/bin/brew shellenv)"
fi

# Install git if not present
if ! command -v git >/dev/null 2>&1; then
  echo "📦 Installing git..."
  brew install git
fi

# Clone dotfiles
DOTFILES_DIR="$HOME/.dotfiles"
if [ ! -d "$DOTFILES_DIR" ]; then
  echo "📥 Cloning dotfiles..."
  git clone --recurse-submodules https://github.com/orionreed/dotfiles.git "$DOTFILES_DIR"
else
  echo "📁 Updating dotfiles..."
  cd "$DOTFILES_DIR" && git pull && git submodule update --init --recursive
fi

# Run Dotbot (handles all configuration, packages, and setup)
echo "⚙️  Running Dotbot installation..."
cd "$DOTFILES_DIR"
"./dotbot/bin/dotbot" -d "$(pwd)" -c "install.conf.yaml"

# Source the new shell configuration
echo "🔄 Applying shell configuration..."
if [ -f "$HOME/.zshrc" ]; then
  source "$HOME/.zshrc"
fi

echo "✅ Setup complete! Your development environment is ready."
