#!/bin/bash
# Minimal bootstrap script for fresh macOS
# Only installs git, then lets Dotbot do everything else

set -e

echo "🚀 Bootstrapping development environment..."

# Install git (minimum needed to clone repo)
if ! command -v git >/dev/null 2>&1; then
  echo "📦 Installing Homebrew (for git)..."
  /bin/bash -c "$(curl -fsSL https://raw.githubusercontent.com/Homebrew/install/HEAD/install.sh)"
  eval "$(/opt/homebrew/bin/brew shellenv)"

  echo "📦 Installing git..."
  brew install git
fi

# Clone dotfiles
DOTFILES_DIR="$HOME/.dotfiles"
if [ ! -d "$DOTFILES_DIR" ]; then
  echo "📥 Cloning dotfiles..."
  git clone --recurse-submodules https://github.com/yourusername/dotfiles.git "$DOTFILES_DIR"
else
  echo "📁 Updating dotfiles..."
  cd "$DOTFILES_DIR" && git pull
fi

# Let Dotbot handle everything else
echo "⚙️  Running Dotbot installation..."
cd "$DOTFILES_DIR"

CONFIG="install.conf.yaml"
DOTBOT_DIR="dotbot"
DOTBOT_BIN="bin/dotbot"

# Update Dotbot submodule
git -C "${DOTBOT_DIR}" submodule sync --quiet --recursive
git submodule update --init --recursive "${DOTBOT_DIR}"

# Run Dotbot (it will handle Homebrew, packages, configs, etc.)
"${DOTBOT_DIR}/${DOTBOT_BIN}" -d "$(pwd)" -c "${CONFIG}"

echo "✅ Setup complete! Restart your terminal."
